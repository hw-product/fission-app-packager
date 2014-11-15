class Packager::RepositoryController < ApplicationController

  prepend_before_action do
    @repo = Repository.find(params[:id])
    params[:account_id] = @repo.account_id
  end

  def show
    @github = github(:bot)
  end

end
