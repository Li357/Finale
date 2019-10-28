# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login, null: true,
      description: "Login with username and password"
  end
end
