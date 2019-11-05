# frozen_string_literal: true

module Errors
  class DuplicateError < GraphQL::ExecutionError
    def extensions
      { code: "DUPLICATE" }
    end
  end
end
