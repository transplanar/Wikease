class UserController < ApplicationController
  def new
    @user = User.new
  end

  def index
    # TODO set this up to work with Pundit gem
    @users = User.all
  end

# IDEA add private users?
  def show
    @users = User.all
  end
end
