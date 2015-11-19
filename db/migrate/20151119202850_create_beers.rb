class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.text :description
      t.string :style
      t.decimal :abv
      t.integer :ibu
      t.string :brewery
      t.string :location

      t.timestamps null: false
    end
  end
end
