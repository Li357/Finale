# frozen_string_literal: true

module Types
  class StudentType < Types::BaseObject
    implements Types::UserType
    description "Student"

    field :courses, [Types::CourseType], null: false,
      description: "List of student's courses"
    field :finals, [Types::FinalType], null: false,
      description: "List of student's finals they've signed up for"
  end
end
