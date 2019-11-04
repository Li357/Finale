# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login, null: true,
      description: "Login with username and password"
    field :signup_for_final, mutation: Mutations::SignupForFinal, null: true, auth: [:student],
      description: "Signup for a final"
  end
end
