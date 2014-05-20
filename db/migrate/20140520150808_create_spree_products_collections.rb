class CreateSpreeProductsCollections < ActiveRecord::Migration
  def change
    create_table :spree_products_collections do |t|
      t.integer :product_id
      t.integer :collection_id
    end
  end
end
