Rails.application.routes.draw do
  get 'admin' => 'admin#index', :as => :admin
  resources :redactor_uploads, :only => [:index, :create]
  if Rails.env.development?
    get 'bootstrap' => 'bootstrap#index'
  end
end
