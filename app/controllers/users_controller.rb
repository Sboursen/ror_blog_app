class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.params[:id]
  end
end
