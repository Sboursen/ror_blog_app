class CommentsController < ApplicationController
  def new; end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    text = params[:text]

    new_comment = Comment.new(text:, post:, author: user)

    if new_comment.save
      redirect_to user_post_url(user, post)
    else
      render :new
    end
  end
end
