Rails.application.routes.draw do
  root to: 'organizations#index'
  resources :organizations, only: [:index, :show, :edit, :create, :update]
  resources :users, only: [:index, :show, :edit, :create, :update]
  namespace :api do
    resources :users, only: [:create, :update], constraints: {id: /[^\/]+/}
    resources :courses, only: [:create]
    '/courses/:organization/:course'.tap do |it|
      post "#{it}/students" => 'students#create'
      post "#{it}/students/:uid/attach" => 'students#attach'
      post "#{it}/students/:uid/detach" => 'students#detach'
      post "#{it}/teachers" => 'teachers#create'
      post "#{it}/teachers/:uid/attach" => 'teachers#attach'
      post "#{it}/teachers/:uid/detach" => 'teachers#detach'
    end
  end
end