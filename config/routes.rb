require 'sidekiq/web'

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :organizations do
      resources :posts
      resources :users do
        collection do
          resource :registrations, only: [:show, :create]
          resource :sessions, only: [:show, :create, :destroy]
          resource :confirmations, only: [:show]
        end
      end
    end
  end

  root 'organizations#welcome'

  mount Sidekiq::Web => '/sidekiq'
end
