# frozen_string_literal: true

module Types
  class UserError < BaseObject
    description "User-readable error"

    field :message, String, null: false,
      description: "Description of the error"
  end
end
