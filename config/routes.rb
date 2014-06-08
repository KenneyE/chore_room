Rails.application.routes.draw do
  root to: 'chore_assignments#index'
  resource :session, only: :new
  resources :chores
  resources :users, only: [:show, :index]

  get "/auth/github/callback", to: "sessions#create"
  delete "/signout", to: "sessions#destroy", as: "signout"
  post "/chore_assignments/send_chores", to: "chore_assignments#send_chores", as: "send_chores"
  get "/chore_assignments/complete/:id", to: "chore_assignments#complete", as: "complete_chore"
  get "/chore_assignments/flagged/:id", to: "chore_assignments#flagged", as: "flag_chore"
  get "/static_pages/thank_you", to: "static_pages#thank_you", as: "thank_you"
end
