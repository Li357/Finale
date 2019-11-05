# frozen_string_literal: true

class GraphqlChannel < ApplicationCable::Channel
  include GraphQL::Extras::Controller

  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    query = data[:query]
    variables = cast_graphql_params(data[:variables])
    operation_name = data[:operationName]
    context = {
      channel: self,
    }
    result = FinaleSchema.execute(query, context: context, variables: variables, operation_name: operation_name)
    payload = {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?,
    }

    # Track the subscription here so we can remove it
    # on unsubscribe.
    if result.context[:subscription_id]
      @subscription_ids << context[:subscription_id]
    end

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each { |sid|
      FinaleSchema.subscriptions.delete_subscription(sid)
    }
  end
end
