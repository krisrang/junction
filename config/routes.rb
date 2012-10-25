Junction::Application.routes.draw do
  if Rails.env.development?
    mount Contact::Preview => 'mail_view'
  end

  resources :post, only: [:show]
  
  get "post/:id/*seo"     => "post#show"
  get "tags/:tag"         => "post#tag",            as: :tag
  get "projects"          => "post#projects",       as: :projects
  post "message"          => "modal#contact_send",  as: :send_contact  
  
  match "modal/:action", controller: "modal"

  root to: "post#index"
end
