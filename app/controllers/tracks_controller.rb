class TracksController < ApplicationController
  def create
    track = Track.create(playlist_id: params['playlist_id'], text_content: params['content'])
    render json: {id: track.id, content: track.text_content}
  end
end
