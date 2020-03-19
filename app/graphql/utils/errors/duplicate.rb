# frozen_string_literal: true

module Errors
  class Duplicate < GraphQL::ExecutionError
    def extensions
      { code: "DUPLICATE" }
    end
  end
end
