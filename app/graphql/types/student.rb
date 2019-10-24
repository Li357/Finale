# frozen_string_literal: true

module Types
  class Student < BaseObject
    description "Student"

    field :name, String, null: false,
      description: "Student's name"
    field :photo, String, null: true,
      description: "Student's profile picture URI"
    field :courses, [Course], null: false,
      description: "List of student's courses"
    field :finals, [Final], null: false,
      description: "List of student's finals they've signed up for"
  end
end
