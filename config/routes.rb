Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'homes#index'
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
    resources :missions, except: [:show] do
      resources :projects, only: %i[index new create]
    end
    resources :projects, only: %i[edit update destroy] do
      resources :milestones, only: %i[index new create]
    end
    resources :milestones, only: %i[edit update destroy] do
      resources :requirements, only: %i[index new create]
    end
    resources :requirements, only: %i[edit update destroy] do
      resources :tickets, only: %i[index new create]
    end
    resources :tickets, only: %i[edit update destroy]
  end
end
