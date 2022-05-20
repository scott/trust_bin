Rails.application.routes.draw do
  devise_for :users
  resources :pastes, param: :uuid do
    get "fork" => "pastes#fork"
  end

  root to: "pastes#index"
end
