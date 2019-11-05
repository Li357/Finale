# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    include GraphQL::Extras::Types

    field_class BaseField
  end
end
