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

  def downgrade
    # TODO change Stripe account to reflect downgrade
    current_user.downgrade_role

    flash[:notice] = "#{current_user.email} account downgraded to #{current_user.role}."
    redirect_to user_path(current_user)
  end
end
