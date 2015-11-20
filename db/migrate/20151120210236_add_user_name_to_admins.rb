class AddUserNameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :user_name, :string
    add_index :admins, :user_name, unique: true  

  end
end
