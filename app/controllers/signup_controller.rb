class SignupController < ApplicationController

  layout "signup"

  def new
    @user = User.new
    @user.build_person
  end

  def create
    @user = User.new(user_params)
    if @user.save
      save_user_id
      redirect_to @user
    else
      render "signup/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, people_attributes: [:last_name,
                                                                                                :first_name])
  end

  #Set created_user and updated_user attr after save user without timestamps
  def save_user_id
    User.record_timestamps = false
    @user.update(created_user: @user.id, updated_user: @user.id)
    User.record_timestamps = true
  end
end
