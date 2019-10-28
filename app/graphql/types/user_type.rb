# frozen_string_literal: true

module Types
  class UserType < Types::BaseUnion
    description "A teacher or student"
    possible_types Types::StudentType, Types::TeacherType

    def self.authorized?(object, context)
      super && object
    end

    def self.resolve_type(object, context)
      return unless context[:current_user]
      context[:current_user].teacher? ? Types::TeacherType : Types::StudentType
    end
  end
end
