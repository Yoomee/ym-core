Rails.application.routes.draw do
  match "admin" => "admin#index", :as => :admin
  match 'super' => 'super#index'
  match 'super/morph' => 'super#morph', :via => :post
end
