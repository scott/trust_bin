Rails.application.routes.draw do
  devise_for :users
  resources :users, param: :uuid
  resources :snippets, param: :uuid do
    get "fork" => "snippets#fork"
  end

  root to: "snippets#index"
end
