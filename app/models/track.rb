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

class Track < ActiveRecord::Base
  belongs_to :playlist
  enum content_type: [:text, :youtube]
  validate :youtube_validator
  validates :content_type, :playlist_id, :text_content, presence: true

  def to_html
    if self.content_type == 'text'
      ActionView::Helpers::TagHelper.content_tag(:div, self.text_content, class: 'track-content track-text')
    elsif self.content_type == 'youtube'
      ActionView::Helpers::TagHelper.content_tag(:div, content_tag(:iframe, nil, src: self.text_content), class: 'track-content track-youtube')
    end
  end

  private

    def youtube_validator
      if self.content_type == 'youtube'
        begin
          video = Yt::Video.new url: self.text_content
          self.name = video.title
          self.text_content = video.embed_html
        rescue Exception => e
          errors.add(:text_content, 'is not a valid youtube video link')
          puts e.message
        end
      end
    end
end
