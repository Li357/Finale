# frozen_string_literal: true

module Types
  class Teacher < BaseObject
    description "Teacher"

    field :name, String, null: false,
      description: "Teacher's name"
    field :photo, String, null: true,
      description: "Teachers's profile picture URI"
    # NOTE: Some departments (e.g. Physics) have finals that administered by all Physics
    #       department teachers, and all should be notified–those are included in this array
    field :courses, [Course], null: false,
      description: "List of teacher's courses, includes courses with department-wide finals"
  end
end
