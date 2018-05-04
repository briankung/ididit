Rails.application.routes.draw do
  get 'day/:date' => 'days#edit', as: :day_edit
  get 'search/' => 'search#create', as: :search

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  resources :posts
  resources :dones, path: '/', except: :new
end
