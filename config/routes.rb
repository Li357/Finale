Rails.application.routes.draw do
  post "/login", to: "authentication#login"
  post "/logout", to: "authentication#logout"
  post "/graphql", to: "graphql#execute"
  get "*path", to: "application#frontend", constraints: ->(request) { frontend_request?(request) }

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  mount ActionCable.server, at: '/cable'

  def frontend_request?(request)
    !request.xhr? && request.format.html?
  end
end
