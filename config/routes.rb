Rails.application.routes.draw do
  namespace :packager do
    resources :repositories
    resources :jobs
  end
end
