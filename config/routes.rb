Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :organizations do
      resources :posts, :users
    end
  end

  root 'organizations#index'
end
