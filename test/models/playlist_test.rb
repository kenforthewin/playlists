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

require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
