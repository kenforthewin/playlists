# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  playlist_id :integer
#  comment_id  :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user
  belongs_to :comment

  has_many :comments

  validates :user_id, :playlist_id, :body, presence: true
end
