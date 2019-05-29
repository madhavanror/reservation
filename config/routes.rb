Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# post 'create_ticket', to: 'application#create_ticket'
# get 'ticket/:id', to: 'application#show_ticket'
# get 'tickets', to: 'application#show_tickets'


namespace :api, defaults: { format: :json } do
  namespace :v1 do
  	resource :tickets, only: %i(create) do
  	  get  :show_tickets, on: :collection
      get 'ticket/:id', to: 'tickets#show_ticket', on: :collection
    end
  end
end

resources :tickets, only: %i(index show destroy)
end
