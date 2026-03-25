Rails.application.routes.draw do
  devise_for :users,
             path: "api/v1/auth",
             path_names: {
               sign_in: "sign_in",
               sign_out: "sign_out",
               registration: "sign_up"
             },
             defaults: { format: :json },
             controllers: {
               sessions: "api/v1/sessions",
               registrations: "api/v1/registrations"
             }

  namespace :api do
    namespace :v1 do
      resource :me, only: :show, controller: :current_user
      resource :dashboard, only: :show
      resources :books
      resources :borrowings, only: %i[index create] do
        patch :return_book, path: "return", on: :member
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"
  get "*path", to: "home#index",
               constraints: ->(request) {
                 request.format.html? &&
                   !request.path.start_with?("/rails/") &&
                   !request.path.start_with?("/api/")
               }
end
