class AddBeerAdvocateToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :beer_advocate, :decimal
  end
end
