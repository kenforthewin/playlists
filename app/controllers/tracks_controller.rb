class TracksController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :set_track, only: :destroy
  def create
    track = Track.create(playlist_id: params['playlist_id'], text_content: params['content'], content_type: params['content_type'].to_i)
    render json: {id: track.id, content: track.text_content}
  end

  def destroy
    @track.destroy
    render nothing: true
  end

  private

    def set_track
      @track = Track.find(params['id'])
    end
end
