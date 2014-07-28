class UsersController < ApplicationController
  layout "default"

  before_action :signed_in_user
  #before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.build_person
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :language,
                                 person_attributes: [ :last_name,
                                                      :first_name,
                                                      :middle_name,
                                                      :birthday,
                                                      :sex ])
  end

  # Before filters

  def signed_in_user
    store_location
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    @created_user = @user.created_user
    unless current_user?(@user) && current_user?(@created_user)
      redirect_to(root_url)
    end
  end
end
