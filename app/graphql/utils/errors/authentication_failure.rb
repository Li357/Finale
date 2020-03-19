# frozen_string_literal: true

module Errors
  class AuthenticationFailure < GraphQL::ExecutionError
    def initialize
      super "Authentication failed, incorrect username or password"
    end

    def extensions
      { code: "AUTHENTICATION_FAILURE" }
    end
  end
end
