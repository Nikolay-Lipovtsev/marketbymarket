class UsersController < ApplicationController
  layout 'projects'

  def index
    @users = User.all
  end

  def signup
    @user = User.new
    render layout: 'signup'
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_param)
    if @user.save
      save_user_id
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  #Set created_user and updated_user attr after save user without timestamps
  def save_user_id
    User.record_timestamps = false
    @user.update(created_user: @user.id, updated_user: @user.id)
    User.record_timestamps = true
  end
end
