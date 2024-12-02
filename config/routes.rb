Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }

      resources :posts, only: [:index, :show, :create] do
        member do
          patch :like
        end
      end

      get 'ping', to: 'tests#ping'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
