Junction::Application.routes.draw do
  resources :post, only: [:show]
  
  get "post/:id/*seo" => "post#show"
  get "tags/:tag"     => "post#tag",      as: :tag
  get "projects"      => "post#projects", as: :projects

  root to: "post#index"
end
