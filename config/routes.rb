Rails.application.routes.draw do
  mount(GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql") if Rails.env.development?

  get 'day/:date' => 'days#edit', as: :day_edit
  get 'search/' => 'search#create', as: :search

  post "/graphql", to: "graphql#execute"
  resources :posts
  resources :dones, path: '/', except: :new
end
