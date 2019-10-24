# frozen_string_literal: true

module Types
  class Final < BaseObject
    description "Final of one Course during a specific mod"

    field :students, [Student], null: false,
      description: "Students signed up for the final"
    field :mod, Integer, null: false,
      description: "Mod the final takes place"
    field :capacity, Integer, null: false,
      description: "Number of students that can sign up for the final"
    field :room, String, null: false,
      description: "Room the final takes place"
  end
end
