class PlaylistsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    playlist = Playlist.create(user_id: current_user.id, name: params['name'], description: params['description'])

    render json: playlist.id
  end

  def show
    @playlist = Playlist.find(params[:id])
    @tracks = playlist.tracks
  end

  private

  def playlist_params
    params.require('playlist').permit('name', 'description', 'user_id')
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end