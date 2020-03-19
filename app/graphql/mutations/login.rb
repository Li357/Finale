# frozen_string_literal: true

module Mutations
  class Login < Mutations::BaseMutation
    SCHOOL_LOGIN_URI = URI("https://westside-web.azurewebsites.net/account/login")

    description "Login with username and password"

    argument :username, String, required: true
    argument :password, String, required: true

    field :token, String, null: false

    def resolve(username:, password:)
      normalized = username.titleize
      user = User.find_by(username: normalized)
      raise Errors::AuthenticationFailure if user.nil?

      response = Net::HTTP.post(SCHOOL_LOGIN_URI, "username=#{normalized}&password=#{password}")
      # School login endpoint returns 301 status if successful, otherwise 200
      raise Errors::AuthenticationFailure unless response.kind_of?(Net::HTTPFound)

      payload = {
        id: user.id,
        roles: user.roles.map { |role| role.role_type },
        exp: 1.day.from_now.to_i,
      }
      token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
      { token: token }
    end
  end
end
