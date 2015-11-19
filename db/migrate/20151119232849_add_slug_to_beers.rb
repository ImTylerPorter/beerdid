class AddSlugToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :slug, :string
    add_index :beers, :slug, unique: true
  end
end
