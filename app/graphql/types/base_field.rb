# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class BaseArgument

    def initialize(*args, auth: [:none], **kwargs, &block)
      @auth = auth
      super(*args, **kwargs, &block)
    end

    def authorized?(object, context)
      @auth.include?(:none) || (!context[:current_user].nil? && context[:current_user].has_roles?(@auth))
    end

    def resolve_field(obj, args, ctx)
      resolve(obj, args, ctx)
    end
  end
end
