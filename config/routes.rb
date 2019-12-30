require 'sidekiq/web'

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :organizations do
      resources :posts, :users
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  root 'organizations#index'
end