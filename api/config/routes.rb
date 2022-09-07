Rails.application.routes.draw do
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]

  namespace :api do
    # identity
    get 'me', to: 'users#show'
    post 'users', to: 'users#create'
    post 'generate_token', to: 'auth#generate_token'

    # invoice
    post 'invoice', to: 'invoice#create'
    get 'invoice', to: 'invoice#get_invoices'
    post 'send_invoice', to: 'invoice#send_invoice'
    get 'download_invoice', to: 'invoice#download_invoice'
  end
end
