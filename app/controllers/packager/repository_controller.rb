class Packager::RepositoryController < ApplicationController

  before_action do
    @repo = current_user.run_state.current_account.repositories_dataset.where(:id => params[:id]).first
  end

  def show
    @github = github(:bot)
  end

end
