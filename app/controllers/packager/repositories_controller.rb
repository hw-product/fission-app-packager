class Packager::RepositoriesController < ApplicationController

  def index
    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_dashboard_url
      end
      format.html do
        @repositories = packager_product.repositories_dataset.where(
          :account_id => current_user.accounts.map(&:id)
        )
      end
    end
  end

  def new
    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_repositories_url
      end
      format.html do
      end
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
