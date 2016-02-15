class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def downgrade
    current_user.downgrade_role

    flash[:notice] = "#{current_user.email} account downgraded to #{current_user.role}."
    redirect_to user_path(current_user)
  end
end
