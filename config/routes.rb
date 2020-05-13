Rails.application.routes.draw do
  devise_for :users

  get '/admin', to: 'admin#index'
  resources 'offers', except: %i[index show] do
    member do
      put 'disable', to: 'offers#disable'
      put 'enable', to: 'offers#enable'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
