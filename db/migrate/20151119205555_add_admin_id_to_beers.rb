class AddAdminIdToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :admin_id, :integer
  end
end
