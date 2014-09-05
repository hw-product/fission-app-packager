module FissionApp
  module Packager
    # Packager related helper methods
    module Utils

      # Controller specific helpers
      module Controller

        # @return [Fission::Data::Models::Product]
        def packager_product
          Product.find_by_name('packager')
        end

        # @return [Array<Fission::Data::Models::ProductFeature>] packager features
        def packager_features
          packager_product.product_features
        end

      end

    end
  end
end
