object @collection
attributes :id, :name, :slug
node(:products_count){ |collection| collection.products_count }

child :products => :products do
  extends 'spree/api/products/show'
end
