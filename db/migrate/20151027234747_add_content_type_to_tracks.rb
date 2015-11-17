class AddContentTypeToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :content_type, :integer
  end
end
