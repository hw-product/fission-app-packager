class Packager::DashboardController < ApplicationController

  def index
    @product = Product.find_by_internal_name('packager')
    @accounts = [
      current_user.owned_accounts,
      current_user.managed_accounts
    ].flatten.uniq.find_all do |acct|
      acct.product_features.map(&:product).include?(@product)
    end

    respond_to do |format|
      format.js do
        flash[:error] = 'Unsupported request!'
        javascript_redirect_to packager_dashboard_path
      end
      format.html do
        @data = Hash[
          @accounts.map do |acct|
            [acct, @product.repositories_dataset.where(:account_id => acct.id)]
          end
        ]
      end
    end
  end

end
