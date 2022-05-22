Rails.application.routes.draw do
  devise_for :users
  resources :snippets, path: 'snippets', param: :uuid do
    get "fork" => "snippets#fork"
  end

  root to: "snippets#index"
end
