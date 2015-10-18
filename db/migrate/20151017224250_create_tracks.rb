class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :playlist_id
      t.text :text_content

      t.timestamps null: false
    end
  end
end
