# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    field :signed_up_for_final, subscription: Subscriptions::SignedUpForFinal, null: false
  end
end
