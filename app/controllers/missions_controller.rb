class MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_mission, only: %i[edit update destroy]

  def index
    @missions = current_user.missions.all
  end

  def new
    @mission = current_user.missions.build
  end

  def edit; end

  def create
    @mission = current_user.missions.build(mission_params)
    @mission.mission_user_relationships.build(user: current_user, role: :owner)
    if @mission.save
      redirect_to missions_path, notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def update
    if @mission.update(mission_params)
      redirect_to edit_mission_path, notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'edit'
    end
  end

  def destroy
    if @mission.destroy
      redirect_back fallback_location: missions_path, notice: t('.succeeded')
    else
      flash[:warning] = t('.failed')
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
