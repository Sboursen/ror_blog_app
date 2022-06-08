class LikesController < ApplicationController
  def new; end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])

    new_like = Like.new(post:, author: user)

    if new_like.save
      redirect_to user_post_url(user, post)
    else
      render :new
    end
  end
end
