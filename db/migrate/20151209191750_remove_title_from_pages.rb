class RemoveTitleFromPages < ActiveRecord::Migration
  def change
  	remove_column :pages, :title
  end
end
