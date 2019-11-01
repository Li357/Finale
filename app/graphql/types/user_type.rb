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
    context[:current_user].name
  end

  def photo
    context[:current_user].photo
  end

  definition_methods do
    def resolve_type(object, context)
      !context[:current_user].nil? && context[:current_user].teacher? ? Types::TeacherType : Types::StudentType
    end

    def authorized?(object, context)
      super && !context[:current_user].nil?
    end
  end
end
