module Spree
  class Collection < ActiveRecord::Base
    has_many :products_collections, class_name: 'Spree::ProductsCollections'
    has_many :products, through: :products_collections
    has_many :taxons, through: :products

    def to_param
      slug
    end
    
  end
end
