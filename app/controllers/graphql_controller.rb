# frozen_string_literal: true

class GraphqlController < ApplicationController
  include GraphQL::Extras::Controller

  def execute
    graphql(
      schema: FinaleSchema,
      context: {
        current_user: current_user,
        cookies: cookies,
      },
    )
  end

  private
    def current_user
      return unless cookies[:_fp] && cookies[:_fs]
      token = "#{cookies[:_fp]}.#{cookies[:_fs]}"
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
      User.find_by(id: payload["id"]).to_role
    rescue ActiveSupport::MessageVerifier::InvalidSignature, JWT::DecodeError, JWT::VerificationError, JWT::ExpiredSignature
      nil
    end
end
