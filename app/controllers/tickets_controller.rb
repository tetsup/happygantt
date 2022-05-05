class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_ticket, only: %i[edit update destroy]
  before_action :fetch_requirement, only: %i[new create]

  def new
    @ticket = @requirement.tickets.build
  end

  def edit; end

  def create
    @ticket = @requirement.tickets.build(ticket_params)
    if @ticket.save
      redirect_to edit_requirement_path(@requirement.id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'new'
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to edit_requirement_path(@ticket.requirement_id), notice: t('.succeeded')
    else
      flash[:alert] = t('.failed')
      render 'edit'
    end
  end

  def destroy
    if @ticket.destroy
      redirect_back fallback_location: missions_path, notice: t('.succeeded')
    else
      flash[:warning] = t('.failed')
    end
  end

  private

  def fetch_ticket
    @ticket = current_user.tickets.find(params[:id])
  end

  def fetch_requirement
    @requirement = current_user.requirements.find(params[:requirement_id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description, :planned_start_date, :planned_end_date,
                                 :started_date, :ended_date, :status, :costs)
  end
end
