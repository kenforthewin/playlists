# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  playlist_id  :integer
#  text_content :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_type :integer
#  name         :string
#

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
