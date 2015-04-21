class Packager::RepositoryController < ApplicationController

  before_action do
    @repo = current_user.run_state.current_account.repositories_dataset.where(:id => params[:id]).first
  end

  def show
    @github = github(:bot)
    @table_headers = ['Package', 'Release', 'Version', 'Download count', 'Size', 'Author', 'Published']
    @table_data    = []

    vc = view_context
    @github.releases(@repo.name).each do | release |
      release.assets.each do | asset |
        @table_data <<
          [vc.link_to(asset.name, asset.browser_download_url),
           release.name,
           vc.link_to(release.tag_name, release.html_url),
           asset.download_count,
           vc.number_to_human_size(asset.size),
           vc.link_to(release.author.login,release.author.html_url),
           "#{release.published_at.strftime("%m-%d-%Y")} (#{vc.time_ago_in_words(release.published_at)} ago)"]
      end
    end
  end

end
