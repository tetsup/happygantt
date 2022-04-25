Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'homes#index'
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
    resources :missions
  end
end
