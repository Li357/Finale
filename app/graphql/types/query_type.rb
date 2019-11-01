# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: true

    def user
      return if context[:current_user].nil?
      context[:current_user].to_role
    end
  end
end
