class CreateSpreeCollections < ActiveRecord::Migration
  def change
    create_table :spree_collections do |t|
      t.string :name
      t.string :slug
    end
  end
end
