Rails.application.routes.draw do
  namespace :api do
    # identity
    get 'me', to: 'users#show'
    post 'users', to: 'users#create'
    post 'generate_token', to: 'auth#generate_token'

    # invoice
    post 'invoice', to: 'invoice#create'
    get 'invoice', to: 'invoice#get_invoices'
  end
end
