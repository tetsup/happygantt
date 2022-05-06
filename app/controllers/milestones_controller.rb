class MilestonesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_milestone, only: %i[edit update destroy]
  before_action :fetch_requirements, only: [:edit]
  before_action :fetch_project, only: %i[new create]

  def new
    @milestone = @project.milestones.build
  end

  def edit; end

  def create
    @milestone = @project.milestones.build(milestone_params)
    if @milestone.save
      redirect_to edit_project_path(@project.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def update
    if @milestone.update(milestone_params)
      redirect_back fallback_location: edit_milestone_path(@milestone.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'edit'
    end
  end

  def destroy
    if @milestone.destroy
      redirect_back fallback_location: missions_path, notice: t('.succeeded')
    else
      flash[:warning] = t('.failed')
    end
  end

  private

  def fetch_milestone
    @milestone = current_user.milestones.find(params[:id])
  end

  def fetch_requirements
    @requirements = current_user.requirements.where(milestone_id: params[:id]).includes_tickets_by_status.all
  end

  def fetch_project
    @project = current_user.projects.find(params[:project_id])
  end

  def milestone_params
    params.require(:milestone).permit(:name, :description, :due_date, :close_date, :status)
  end
end
