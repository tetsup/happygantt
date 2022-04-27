class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_mission, only: %i[new create]
  before_action :fetch_project, only: %i[edit show destroy]

  def create
    @project = @mission.projects.build(project_params)
    @project.project_user_relationships.build(user: current_user, role: :owner)
    if @project.save
      redirect_to edit_mission_path(params[:mission_id]), notice: t('.project.create.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def new
    @project = @mission.projects.build
  end

  def edit; end

  def show; end

  def destroy
    if @project.destroy
      redirect_back fallback_location: missions_path, notice: t('.mission.destroy.succeeded')
    else
      flash[:warning] = t('.mission.destroy.failed')
    end
  end

  private

  def fetch_mission
    @mission = current_user.missions.find(params[:mission_id])
  end

  def fetch_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
