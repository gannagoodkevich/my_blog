Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :organizations do
      resources :posts, :users
    end
  end

  resources :user_auths do
    collection do
      resource :registrations, only: [:show, :create]
      resource :sessions, only: [:new, :create, :destroy]
      resource :confirmations, only: [:show]
    end
  end
  root 'organizations#index'
end
