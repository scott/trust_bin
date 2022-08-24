Rails.application.routes.draw do

  devise_for :users
  
  namespace :admin do
    resources :users, param: :uuid
  end
  resources :snippets, param: :uuid do
    get "fork" => "snippets#fork"
    get "raw" => "snippets#raw"
  end

  root to: "snippets#index"
end
