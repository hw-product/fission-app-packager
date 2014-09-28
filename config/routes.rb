Rails.application.routes.draw do
  namespace :packager do
    resources :accounts, :only => [] do
      resources :repositories
      resources :jobs
    end
  end
end
