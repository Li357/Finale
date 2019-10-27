module Types
  class UserType < Types::BaseUnion
    description "A teacher or student"
    possible_types Types::StudentType, Types::TeacherType

    def self.resolve_type(object, context)
      if object.teacher?
        Types::TeacherType
      else
        # Better to assume less privileged role
        Types::StudentType
      end
    end
  end
end
