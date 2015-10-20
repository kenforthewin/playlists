# == Schema Information
#
# Table name: playlists
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pic_file_name    :string
#  pic_content_type :string
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#  published        :boolean          default(FALSE)
#

class Playlist < ActiveRecord::Base
  has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/
  belongs_to :user
  has_many :tracks
end
