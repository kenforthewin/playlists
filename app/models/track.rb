# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  playlist_id  :integer
#  text_content :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :playlist
end
