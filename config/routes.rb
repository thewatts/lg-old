Lg::Application.routes.draw do

  root "home#index"
  get '/leaders/signup', :to => "leaders#index", :as => :leader_signup

  resources :users, :only => [:create]

  namespace :leader, :param => :login do
    root "lifegroups#index", :as => :dashboard
    resources :lifegroups, :path => "groups"
  end

  namespace :admin do
    root "dashboard#index", :as => :dashboard
    resources :semesters
  end

end
