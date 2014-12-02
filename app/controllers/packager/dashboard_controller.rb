class Packager::DashboardController < ApplicationController

  def index
    @accounts = [@account]
    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_dashboard_path
      end
      format.html do
        jobs_dataset = Job.dataset_with(
          :collections => {
            :complete => ['complete']
          },
          :scalars => {
            :repository_name => ['data', 'github', 'repository', 'full_name']
          }
        ).where('? = ANY(complete)', @product.internal_name)
        @data = Hash[
          @accounts.map do |acct|
            [
              acct,
              Hash[
                @product.repositories_dataset.where(:account_id => acct.id).all.map do |repo|
                  [repo, jobs_dataset.where(:repository_name => repo.name)]
                end
              ]
            ]
          end
        ]
      end
    end
  end

end
