class AddTermsToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :terms, :boolean, default: false
  end
end
