Rails.application.routes.draw do
  devise_for :users
  resources :pastes, path: 'snippets', param: :uuid do
    get "fork" => "pastes#fork"
  end

  root to: "pastes#index"
end
