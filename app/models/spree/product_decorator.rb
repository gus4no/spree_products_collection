Spree::Product.class_eval do
  has_many :products_collections, class_name: 'Spree::ProductsCollections'
  has_many :collections, through: :products_collections
end
