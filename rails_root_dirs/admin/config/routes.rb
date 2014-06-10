Rails.application.routes.draw do
  root  'application#home'
  devise_for :administrators, controllers: { sessions: "admin/sessions" }

  namespace :admin do
    root 'application#home'
  end
end
