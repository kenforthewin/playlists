class CommentsController < ApplicationController
  def create
    Comment.create(user_id: params['user_id'], playlist_id: params['playlist_id'], body: params['body'])
    render json: {email: User.find(params['user_id']).email, body: params['body']}
  end
end
