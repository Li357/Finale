# frozen_string_literal: true

module Types
  class TeacherType < Types::BaseObject
    implements Types::UserType
    description "Teacher"

    # NOTE: Some departments (e.g. Physics) have finals that administered by all Physics
    #       department teachers, and all should be notified–those are included in this array

    # TODO: add finals to type, multiple teachers can administer final of one class
    field :courses, [Types::CourseType], null: false,
      description: "List of teacher's courses, includes courses with department-wide finals"
  end
end
