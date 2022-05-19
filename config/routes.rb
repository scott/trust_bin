Rails.application.routes.draw do
  devise_for :users
  resources :pastes, param: :uuid
  root to: "pastes#index"
end
