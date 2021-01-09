Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'hello/index'
  post '/callback' => 'line_bot#callback'

end
