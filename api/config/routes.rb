Rails.application.routes.draw do
  namespace :api do
    get 'me', to: 'users#show'
    post 'users', to: 'users#create'
    post 'generate_token', to: 'auth#generate_token'
  end
end
