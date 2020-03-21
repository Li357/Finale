# frozen_string_literal: true

# Handles login and logout JWT authentication for graphql api for web and non-web clients
class AuthenticationController < ApplicationController
  def login
    username = params[:username]
    password = params[:password]
    render status: :bad_request if (username.nil? or password.nil?) and return

    normalized = username.titleize
    user = User.find_by(username: normalized)
    render status: :unauthorized if user.nil? and return

    # School login endpoint returns 301 status if successful, otherwise 200
    response = Net::HTTP.post(Constants::SCHOOL_LOGIN_URI, "username=#{normalized}&password=#{password}")
    render status: :unauthorized unless response.kind_of?(Net::HTTPFound) and return

    payload = {
      id: user.id,
      roles: user.roles.map { |role| role.role_type },
      exp: 1.day.from_now.to_i,
    }
    token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
    if headers['X-Requested-With'] == Constants::FINALE_NATIVE_CLIENT
      render json: { token: token } and return
    end

    header, payload, signature = token.split('.')
    cookies[Constants::FINALE_COOKIE_PAYLOAD] = { value: "#{header}.#{payload}", expires: 1.day }
    cookies[Constants::FINALE_COOKIE_SIGNATURE] = { value: signature, expires: 1.day }
    render status: :ok
  end

  def logout
    cookies.delete Constants::FINALE_COOKIE_PAYLOAD
    cookies.delete Constants::FINALE_COOKIE_SIGNATURE
    render status: :ok
  end
end
