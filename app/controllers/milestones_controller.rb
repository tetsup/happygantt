class MilestonesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_milestone, only: %i[edit update destroy]
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

  def destroy; end

  private

  def fetch_milestone
    @milestone = current_user.milestones.find(params[:id])
  end

  def fetch_project
    @project = current_user.projects.find(params[:project_id])
  end

  def milestone_params
    params.require(:milestone).permit(:name, :description, :due_date, :close_date, :status)
  end
end
