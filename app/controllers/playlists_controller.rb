class PlaylistsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    params[:playlist][:user_id] = current_user.id
    playlist = Playlist.create(playlist_params)
    redirect_to root_path
  end

  private

    def playlist_params
      params.require(:playlist).permit(:name, :description, :user_id)
    end

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end
end