class Packager::RepositoriesController < ApplicationController

  def index
    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_dashboard_path
      end
      format.html do
        @accounts = (current_user.owned_accounts +
          current_user.managed_accounts).uniq
        @repositories = packager_product.repositories_dataset.where(
          :account_id => current_user.accounts.map(&:id)
        ).all.group_by do |repo|
          repo.account
        end
      end
    end
  end

  def new
    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_repositories_path
      end
      format.html do
        unless(params[:account])
          flash[:error] = 'Failed to detect account.'
          redirect_to packager_repositories_path
        else
          @account = Account.find_by_name(params[:account])
          begin
            @repositories = github(:user).org_repos(params[:account])
          rescue Octokit::NotFound
            @repositories = github(:user).repos
          end
        end
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
