Lg::Application.routes.draw do

  root 'home#index'
  get '/leaders/signup', :to => 'leaders#index', :as => :leader_signup
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => redirect('/')

  resources :users, :only => [:create]

  namespace :leader, :path => ":nickname", :constraints => { :nickname => /[\w+(\.|\-)?]+/ }  do
    get '/finish',   :to => 'users#finish_signup', :as => :finish_signup
    patch '/finish', :to => 'users#update_signup_attributes'
    root 'lifegroups#index', :as => :dashboard
    resources :lifegroups, :path => 'groups'
  end

  namespace :admin do
    root 'dashboard#index', :as => :dashboard
    resources :semesters
  end

end
