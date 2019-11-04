# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: true, auth: [:student, :teacher]

    def user
      context[:current_user]
    end
  end
end
