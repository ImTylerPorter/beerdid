class AddYoutubeUrlToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :youtube_url, :string
  end
end
