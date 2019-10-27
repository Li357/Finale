# frozen_string_literal: true

module Types
  class TeacherType < Types::BaseObject
    description "Teacher"

    field :name, String, null: false,
      description: "Teacher's name"
    field :photo, String, null: true,
      description: "Teachers's profile picture URI"
    # NOTE: Some departments (e.g. Physics) have finals that administered by all Physics
    #       department teachers, and all should be notified–those are included in this array
    field :courses, [Types::CourseType], null: false,
      description: "List of teacher's courses, includes courses with department-wide finals"

    def name
      [object.first_name, object.middle_name, object.last_name, object.suffix] * " "
    end

    def photo
      object.profile_photo
    end
  end
end
