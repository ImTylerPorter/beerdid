class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :admin_id
      t.integer :beer_id

      t.timestamps null: false
    end
  end
end
