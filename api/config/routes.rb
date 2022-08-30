Rails.application.routes.draw do
  namespace :api do
    get 'me', to: 'users#show'
    post 'users', to: 'users#create'
  end
end
