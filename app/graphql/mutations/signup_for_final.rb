# frozen_string_literal: true

module Mutations
  class SignupForFinal < Mutations::BaseMutation
    include Helpers::Authorization

    description "Signup for a final"

    argument :id, Integer, required: true

    field :final, Types::FinalType, null: true

    def resolve(id:)
      final = can_view_final!(context[:current_user], Final.find_by(id: id))
      final.signup(context[:current_user]) { |modified|
        FinaleSchema.subscriptions.trigger(:signed_up_for_final, { id: id }, modified)
        { final: modified }
      }
    rescue ActiveRecord::RecordNotUnique
      raise Errors::DuplicateError, "Cannot sign up for final twice!"
    end
  end
end
