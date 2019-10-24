require 'jwt'

module Mutations
  class Login < Mutations::BaseMutation
    argument :username, String, required: true
    argument :password, String, required: true

    field :token, String, null: false
    field :errors, [Types::UserError], null: false

    def resolve(username:, password:)
      user = User.where(username: username)
      failed_response = { error: [ message: "Authentication failed. Incorrect username or password" ] }

      return failed_response unless user.exists?

      # TODO: request to school website, if good, sign JWT token
    end
  end
end
