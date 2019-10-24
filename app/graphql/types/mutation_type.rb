# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :login, mutation: Mutations::Login,
      description: "Login with username and password"
  end
end
