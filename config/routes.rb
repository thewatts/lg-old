Lg::Application.routes.draw do

  root "home#index"
  get '/leaders/signup', :to => "leaders#index", :as => :leader_signup
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => redirect('/')

  resources :users, :only => [:create]

  namespace :leader, :path => ":nickname" do
    root "lifegroups#index", :as => :dashboard
    resources :lifegroups, :path => "groups"
  end

  namespace :admin do
    root "dashboard#index", :as => :dashboard
    resources :semesters
  end

end
