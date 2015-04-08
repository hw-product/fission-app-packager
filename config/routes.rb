Rails.application.routes.draw do
  instance_exec(
    :packager, 'v1/github/packager?push=enabled',
    &FissionApp::Repositories.repositories_routes
  )

  instance_exec(
    :packager,
    &FissionApp::Jobs.jobs_routes
  )

  namespace :packager do
    get 'dashboard', :to => 'dashboard#index', :as => :dashboard
    resources :repository, :only => [:show]
  end
end
