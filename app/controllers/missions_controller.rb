class MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_mission, only: %i[edit show destroy]
  def index
    @missions = current_user.missions.all
  end

  def create
    @mission = current_user.missions.build(mission_params)
    @mission.mission_memberships.build(user: current_user, role: :owner)
    redirect_to missions_path, notice: t('.mission.create.succeeded') if @mission.save
    render 'new', alert: t('.mission.create.failed')
  end

  def new
    @mission = current_user.missions.build
  end

  def edit; end

  def show; end

  def destroy
    if @mission.destroy
      redirect_back fallback_location: missions_path, notice: t('.mission.destroy.succeeded')
    else
      flash[:warning] = t('.mission.destroy.failed')
    end
  end

  private

  def fetch_mission
    @mission = current_user.missions.find(params[:id])
  end

  def mission_params
    params.require(:mission).permit(:name, :description, :status)
  end
end
