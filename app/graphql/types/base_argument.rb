# frozen_string_literal: true

module Types
  class BaseArgument < GraphQL::Schema::Argument
    include GraphQL::Extras::Types
  end
end
