class AddAttachmentPicToPlaylists < ActiveRecord::Migration
  def self.up
    change_table :playlists do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :playlists, :pic
  end
end
