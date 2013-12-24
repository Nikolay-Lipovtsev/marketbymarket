class ProjectsController < ApplicationController
  layout 'signup', only: [:new, :create]

  def new
    @project = Project.new
    @project.users.build
  end

  def show
    @project = Project.find_by(name: params[:name])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      add_created_user
      redirect_to @project
    else
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, users_attributes: [:email, :password, :password_confirmation])
  end

  #Set created_user and updated_user attr after save new project and user without timestamps
  def add_created_user

    @user = @project.users.first
    Project.record_timestamps = false
    User.record_timestamps = false
    params = { project: { created_user: @user.id,
                          updated_user: @user.id,
                          users_attributes: { id: @user.id,
                                              created_user: @user.id,
                                              updated_user: @user.id } } }
    @project.update params[:project]
    User.record_timestamps = true
    Project.record_timestamps = true
  end
end
