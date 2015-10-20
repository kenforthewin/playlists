class AddPublishedToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :published, :boolean, default: false
  end
end
