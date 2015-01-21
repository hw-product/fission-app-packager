module FissionApp
  module Packager
    class Engine < ::Rails::Engine

      config.to_prepare do |config|
        product = Fission::Data::Models::Product.find_by_internal_name('packager')
        unless(product)
          product = Fission::Data::Models::Product.create(
            :name => 'Packager',
            :vanity_dns => 'packager.co'
          )
        end
        feature = Fission::Data::Models::ProductFeature.find_by_name('packager_full_access')
        unless(feature)
          feature = Fission::Data::Models::ProductFeature.create(
            :name => 'packager_full_access',
            :product_id => product.id
          )
        end
        unless(feature.permissions_dataset.where(:name => 'packager_full_access').count > 0)
          args = {:name => 'packager_full_access', :pattern => '/packager.*'}
          permission = Fission::Data::Models::Permission.where(args).first
          unless(permission)
            permission = Fission::Data::Models::Permission.create(args)
          end
          unless(feature.permissions.include?(permission))
            feature.add_permission(permission)
          end
        end
      end

      # @return [Array<Fission::Data::Models::Product>]
      def fission_product
        [Fission::Data::Models::Product.find_by_internal_name('packager')]
      end

      # @return [Hash] navigation
      def fission_navigation(*_)
        {
          'Packager' => {
            'Dashboard' => Rails.application.routes.url_helpers.packager_dashboard_path,
            'Repositories' => Rails.application.routes.url_helpers.packager_repositories_path,
            'Jobs' => Rails.application.routes.url_helpers.packager_jobs_path
          }.with_indifferent_access
        }.with_indifferent_access
      end

      # @return [Hash] dashboard information
      def fission_dashboard(*_)
        {
          :packager_dashboard => {
            :title => 'Packager',
            :url => Rails.application.routes.url_helpers.packager_dashboard_path
          }
        }
      end

    end
  end
end
