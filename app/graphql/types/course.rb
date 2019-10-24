# frozen_string_literal: true

module Types
  class Course < BaseObject
    description "Course with many finals during different mods"

    field :name, String, null: false,
      description: "Name of the course"
    field :finals, [Final], null: false,
      description: "List of finals available for the course"
  end
end
