# frozen_string_literal: true

module Types
  module BaseInterface
    include GraphQL::Schema::Interface
    include GraphQL::Extras::Types

    field_class BaseField
  end
end
