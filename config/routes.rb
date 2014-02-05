Lg::Application.routes.draw do

  namespace :admin do
    root "lifegroups#index", :as => :dashboard
    resources :lifegroups
  end

  namespace :overlord do
    root "dashboard#index", :as => :dashboard
    resources :semesters
  end

end
