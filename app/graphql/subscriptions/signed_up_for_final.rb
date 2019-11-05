# frozen_string_literal: true

module Subscriptions
  class SignedUpForFinal < Subscriptions::BaseSubscription
    include Helpers::Authorization

    description "Sends message when a student signs up for a final with specified id"

    argument :id, Integer, required: true

    payload_type Types::FinalType

    def subscribe(id:)
      can_view_final!(context[:current_user], object)
    end
  end
end
