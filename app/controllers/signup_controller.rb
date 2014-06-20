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
      sign_in @user
      redirect_to @user
    else
      render "signup/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 person_attributes: [ :last_name,
                                                      :first_name,
                                                      :birthday])
  end

  #Set created_user and updated_user attr after save user without timestamps
  def save_user_id
    User.record_timestamps = false
    Person.record_timestamps = false
    @user.creator = @user
    @user.refresher = @user
    @user.person.creator = @user
    @user.person.refresher = @user
    User.record_timestamps = true
    Person.record_timestamps = true
  end
end
