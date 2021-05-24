Rails.application.routes.draw do
devise_for :users
root to: "prototypes#index"
resources :prototypes do
resources :comments,only:[:new,:create,:destroy]do
 end
end
resources  :users,only: :show
end
