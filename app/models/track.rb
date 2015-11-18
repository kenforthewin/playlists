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
  enum content_type: [:text, :youtube, :tweet]
  validate :youtube_validator, :tweet_validator
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
          puts 'successfully'
        rescue Exception => e
          errors.add(:text_content, 'is not a valid youtube video link')
          puts e.message
        end
      end
    end

    def tweet_validator
      if self.content_type == 'tweet'
        begin
          response = Net::HTTP.get_response(URI("https://api.twitter.com/1/statuses/oembed.json?url=#{self.text_content}"))
          body = JSON.parse response.body

          if body['html']
            self.text_content = body['html']
          else
            errors.add(:text_content, 'is not a valid tweet link')
          end
        rescue
          errors.add(:text_content, 'is not a valid tweet link')
        end
      end
    end
end
