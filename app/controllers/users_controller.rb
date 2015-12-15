class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    # TODO set this up to work with Pundit gem
    @users = User.all
  end

# IDEA add private users?
  def show
    @user = User.find(params[:id])
  end
end
