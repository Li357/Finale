# frozen_string_literal: true

class FinaleSchema < GraphQL::Schema
  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)

  def self.unauthorized_object(error)
    raise Errors::NotAuthorized
  end

  def self.unauthorized_field(error)
    raise Errors::NotAuthorized
  end
end
