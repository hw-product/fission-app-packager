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

    end
  end
end
