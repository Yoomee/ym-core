Rails.application.routes.draw do
  match 'super' => 'super#index'
  match 'super/morph' => 'super#morph', :via => :post
end
