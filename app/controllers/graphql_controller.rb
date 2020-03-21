# frozen_string_literal: true

class GraphqlController < ApplicationController
  include GraphQL::Extras::Controller

  def execute
    graphql(schema: FinaleSchema, context: { current_user: current_user })
  end

  private
    def get_token
      if request.headers.include?("Authorization")
        request.headers["Authorization"].split(" ").last
      end
      payload = cookies[Constants::FINALE_COOKIE_PAYLOAD]
      signature = cookies[Constants::FINALE_COOKIE_SIGNATURE]
      "#{payload}.#{signature}" unless payload.nil? || signature.nil?
    end

    def current_user
      token = get_token()
      return if token.nil?
      payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
      User.find_by(id: payload["id"]).to_role
    rescue ActiveSupport::MessageVerifier::InvalidSignature, JWT::DecodeError, JWT::VerificationError, JWT::ExpiredSignature
      nil
    end
end
