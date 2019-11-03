# frozen_string_literal: true

module Types
  class TeacherType < Types::BaseObject
    implements Types::UserType
    description "Teacher"

    # NOTE: Some departments (e.g. Physics) have finals that administered by all Physics
    #       department teachers, and all should be notified–those are included in this array

    # TODO: What happens if cotaught course teachers submit differing final requests?
    field :courses, [Types::CourseType], null: false,
      description: "List of teacher's courses for selecting which have finals"
    field :finals, [Types::FinalType], null: false,
      description: "List of teacher's finals which they are supervising"
  end
end
