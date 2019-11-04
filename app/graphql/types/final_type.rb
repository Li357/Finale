# frozen_string_literal: true

module Types
  class FinalType < Types::BaseObject
    description "Final of one Course during a specific mod"

    # TODO: Students are not authorized to see others in final
    field :students, [Types::StudentType], null: false, auth: [:teacher],
      description: "Students signed up for the final"
    field :id, Integer, null: false,
      description: "ID of the final"
    field :mod, Integer, null: false,
      description: "Mod the final takes place"
    field :capacity, Integer, null: false,
      description: "Number of students that can sign up for the final"
    field :signups, Integer, null: false, auth: [:student],
      description: "Number of students that have already signed up for the final"
    field :room, String, null: false,
      description: "Room the final takes place"
  end
end
