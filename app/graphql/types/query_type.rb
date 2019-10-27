# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user, [Types::UserType], null: false do
      argument :id, Integer, required: true
    end

    def user(id:)
      user = User.find(id)
      if user.teacher?
        user.as_teacher
      else
        user.as_student
      end
    end
  end
end
