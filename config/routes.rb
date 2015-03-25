Rails.application.routes.draw do
  root to: "notice#index"
  get '/results', to: 'notice#results'
  post '/create', to: 'notice#create'

end
