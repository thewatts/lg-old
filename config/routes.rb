Lg::Application.routes.draw do

  root 'home#index'
  get '/leaders/signup', :to => 'leaders#index', :as => :leader_signup
  get '/leaders/signup/finish', :to => 'leader/users#finish_signup',
    :as => :leader_finish_signup
  patch '/leaders/signup/finish', :to => 'leader/users#update_signup_attributes'
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => redirect('/')

  resources :users, :only => [:create]

  namespace :leader, :path => ":nickname",
    :constraints => { :nickname => /[\w+(\.|\-)?]+/ }  do
    root 'lifegroups#index', :as => :dashboard
    resources :lifegroups, :path => 'groups', :only => [:index, :new, :create]
    namespace :group_steps, :path => 'groups' do
      get '/:group_number/basics', :to => "basics#edit",   :as => :edit_basics
      put '/:group_number/basics', :to => "basics#update", :as => :basics
      get '/:group_number/specifics', :to => "specifics#edit", :as => :edit_specifics
    end
  end

  namespace :admin do
    root 'dashboard#index', :as => :dashboard
    resources :semesters
  end

end
