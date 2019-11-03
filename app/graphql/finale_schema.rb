# frozen_string_literal: true

class FinaleSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(error)
    raise Errors::NotAuthorizedError
  end

  def self.unauthorized_field(error)
    raise Errors::NotAuthorizedError
  end
end
