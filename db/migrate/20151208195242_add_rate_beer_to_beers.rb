class AddRateBeerToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :rate_beer, :decimal
  end
end
