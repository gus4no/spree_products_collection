module Spree
  class Collection < ActiveRecord::Base
    has_many :products_collections, class_name: 'Spree::ProductsCollections'
    has_many :products, through: :products_collections
    has_many :taxons, through: :products

    validates :name, presence: true
    validates :slug, presence: true

    before_validation :normalize_slug, on: :update

    def to_param
      slug
    end

    def products_count
      products.count
    end

    private
    def normalize_slug
      self.slug = self.slug.to_s.parameterize
    end

  end
end
