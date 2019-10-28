# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: true

    def user
      User.as_role(context[:current_user])
    end
  end
end
