class PlaylistsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :set_playlist, only: [:edit, :show, :destroy, :upvote]
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    if params['playlist_id']
      playlist = Playlist.find(params['playlist_id'])
      if playlist.user_id == current_user.id
        playlist.update(name: params['name'], description: params['description'])
      end
    else
      playlist = Playlist.create(user_id: current_user.id, name: params['name'], description: params['description'])
    end

    render json: playlist.id
  end

  def show
    @tracks = @playlist.tracks

    json_tracks = @tracks.map{|t| {text_content: t.text_content, content_type: nil }}

    respond_to do |format|
      format.json {render json: {id: @playlist.id, name: @playlist.name, description: @playlist.description, tracks: json_tracks} }
      format.html
    end
  end

  def edit
    unless @playlist.user_id == current_user.id
      redirect_to root_path
    end

  end

  def my
    @playlists = Playlist.where(user_id: current_user.id)
  end

  def destroy
    tracks = @playlist.tracks
    tracks.each do |track|
      track.delete
    end

    @playlist.delete
    redirect_to root_path
  end

  def upvote

    unless user_signed_in?
      return render json: false
    end

    @user = current_user
    if @user.voted_for?(@playlist)
      @user.unvote_for(@playlist)
    else
      @user.vote_for(@playlist)
    end

    render nothing: true
  end

  private

  def playlist_params
    params.require('playlist').permit('name', 'description', 'user_id')
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end