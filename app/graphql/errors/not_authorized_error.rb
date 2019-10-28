# frozen_string_literal: true

module Errors
  class NotAuthorizedError < GraphQL::ExecutionError
    def initialize
      super "Not authorized, please supply valid token!"
    end

    def extensions
      { code: "NOT_AUTHORIZED" }
    end
  end
end
