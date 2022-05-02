class RequirementsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_requirement, only: %i[edit update destroy]
  before_action :fetch_milestone, only: %i[new create]

  def new
    @requirement = @milestone.requirements.build
  end

  def edit; end

  def create
    @requirement = @milestone.requirements.build(requirement_params)
    if @requirement.save
      redirect_to edit_milestone_path(@milestone.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def update
    if @requirement.update(requirement_params)
      redirect_back fallback_location: edit_requirement_path(@requirement.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'edit'
    end
  end

  def destroy; end

  private

  def fetch_requirement
    @requirement = current_user.requirements.find(params[:id])
  end

  def fetch_milestone
    @milestone = current_user.milestones.find(params[:milestone_id])
  end

  def requirement_params
    params.require(:requirement).permit(:name, :description)
  end
end
