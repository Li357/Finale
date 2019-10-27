# frozen_string_literal: true

module Types
  class CourseType < Types::BaseObject
    description "Course with many finals during different mods"

    field :name, String, null: false,
      description: "Name of the course"
    field :finals, [Types::FinalType], null: false,
      description: "List of finals available for the course"
  end
end
