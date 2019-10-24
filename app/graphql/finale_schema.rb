# frozen_string_literal: true

class FinaleSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
