# frozen_string_literal: true

module Types::UserType
  include Types::BaseInterface
  description "A user that has queryable information (teacher or student)"

  field :name, String, null: false,
    description: "Name of the user"
  field :photo, String, null: true,
    description: "Profile picture URL of user"

  orphan_types Types::StudentType, Types::TeacherType

  def name
    object.user.name
  end

  def photo
    object.user.photo
  end

  definition_methods do
    def resolve_type(object, context)
      object.user.has_roles?([:teacher]) ? Types::TeacherType : Types::StudentType
    end
  end
end
