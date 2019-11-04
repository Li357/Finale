# frozen_string_literal: true

module Mutations
  class SignupForFinal < Mutations::BaseMutation
    argument :id, Integer, required: true

    field :final, Types::FinalType, null: true

    def resolve(id:)
      final = Final.find_by(id: id)
      attends_course = context[:current_user].courses.any? { |course| course.id == final.course.id }
      raise Errors::NotAuthorizedError unless attends_course

      begin
        modified = final.signup(context[:current_user])
        { final: modified }
      rescue ActiveRecord::RecordNotUnique
        raise Errors::DuplicateError, "Cannot sign up for final twice!"
      end
    end
  end
end
