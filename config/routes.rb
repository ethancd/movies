Rails.application.routes.draw do
  get 'movie/index'

  get 'movie/:id', to: "movie#show"

  root 'movie#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end