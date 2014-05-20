module Spree
  class ProductsCollections < ActiveRecord::Base
    belongs_to :collection
    belongs_to :product
  end
end
