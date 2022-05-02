class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_task, only: %i[edit update destroy]
  before_action :fetch_requirement, only: %i[new create]

  def new
    @task = @requirement.tasks.build
  end

  def edit; end

  def create
    @task = @requirement.tasks.build(task_params)
    if @task.save
      redirect_to edit_requirement_path(@requirement.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to edit_requirement_path(@task.requirement_id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'edit'
    end
  end

  def destroy
    if @task.destroy
      redirect_back fallback_location: missions_path, notice: t('.succeeded')
    else
      flash[:warning] = t('.failed')
    end
  end

  private

  def fetch_task
    @task = current_user.tasks.find(params[:id])
  end

  def fetch_requirement
    @requirement = current_user.requirements.find(params[:requirement_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :planned_start_date, :planned_end_date,
                                 :started_date, :ended_date, :status, :costs)
  end
end
