module FissionApp
  module Packager
    class Engine < ::Rails::Engine

      config.to_prepare do |config|
        product = Fission::Data::Models::Product.find_or_create(
          :name => 'packager',
          :vanity_dns => 'packager.co'
        )
        feature = Fission::Data::Models::ProductFeature.find_or_create(
          :name => 'full_access',
          :product_id => product.id
        )
        unless(feature.permissions_dataset.where(:name => 'packager_full_access').count > 0)
          feature.add_permission(
            :name => 'packager_full_access',
            :pattern => '/packager.*'
          )
        end
      end

      # @return [Array<Fission::Data::Models::Product>]
      def fission_product
        [Fission::Data::Models::Product.find_by_internal_name('packager')]
      end

      # @return [Hash] navigation
      def fission_navigation
        {
          'Packager' => {
            'Dashboard' => Rails.application.routes.url_for(
              :controller => 'packager/dashboard',
              :action => :index,
              :only_path => true
            ),
            'Jobs' => '/packager/jobs'
          }.with_indifferent_access
        }.with_indifferent_access
      end

      # @return [Hash] dashboard information
      def fission_dashboard
        {
          :packager_dashboard => 'Packager'
        }
      end

    end
  end
end
