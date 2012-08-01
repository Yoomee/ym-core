Rails.application.routes.draw do
  match "admin" => "admin#index", :as => :admin
  resources :redactor_uploads, :only => [:index, :create]
end
