# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login, null: true
    field :signup_for_final, mutation: Mutations::SignupForFinal, null: true, auth: [:student, :teacher]
  end
end
