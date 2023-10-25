Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'member/:id', to: 'members#show', as: 'member'
  get 'edit_description/:id', to: 'members#edit_description', as: 'edit_member_description'
end
