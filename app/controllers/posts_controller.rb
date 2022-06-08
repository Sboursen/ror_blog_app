class PostsController < ApplicationController
  def index
    author_id = params[:user_id]
    @user = User.find(author_id)
    @posts = @user.posts
  end

  def show
    id = params[:id]
    @post = Post.find(id)
  end

  def new; end

  def create
    user = User.find(params[:user_id])
    text = params[:text]
    title = params[:title]

    new_post = Post.new(title:, text:, author: user)

    if new_post.save
      redirect_to user_post_url(user, new_post)
    else
      render :new
    end
  end
end
