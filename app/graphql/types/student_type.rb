# frozen_string_literal: true

module Types
  class StudentType < Types::BaseObject
    description "Student"

    field :name, String, null: false,
      description: "Student's name"
    field :photo, String, null: true,
      description: "Student's profile picture URI"
    field :courses, [Types::CourseType], null: false,
      description: "List of student's courses"
    field :finals, [Types::FinalType], null: false,
      description: "List of student's finals they've signed up for"
  
    def name
      [object.first_name, object.middle_name, object.last_name, object.suffix] * " "
    end

    def photo
      object.profile_photo
    end
  end
end
