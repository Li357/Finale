module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login,
      description: "Login with username and password"
  end
end
