class PackagerDashboardCell < DashboardCell

  def show(args)
    super
    @packager = Product.find_by_internal_name('packager')
    dataset = Job.dataset_with(:scalars => {:status => ['status']})
    @jobs_summary = {
      :in_progress => dataset.where(:status => 'active').count,
      :error => dataset.where(:status => 'error').count,
      :complete => dataset.where(:status => 'complete').count
    }

    repos = current_user.run_state.current_account.repositories_dataset.
      eager_graph(:products).where(:products__id => @packager.id).
      all.map{|repo|repo.name}
    counts = repos.map do |repo|
      begin
        github(:bot).releases(repo).map do |release|
          release.assets.map do |asset|
            {:name => "#{repo}/#{release.name}", :count => asset.download_count}
          end
        end
      rescue => e
        nil
      end
    end.flatten.compact
    @popular = counts.sort_by { |k| k[:count] }.last(5).reverse
    render
  end

end
