Lg::Application.routes.draw do
  namespace :admin do
    root "lifegroups#index", :as => :dashboard
    resources :lifegroups
  end
end
