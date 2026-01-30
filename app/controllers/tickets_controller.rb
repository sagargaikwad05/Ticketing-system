class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]

  def index
    render json: Ticket.all
  end

  def show
    render json: @ticket
  end

  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: ticket, status: :created
    else
      render json: { errors: ticket.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    render json: { message: "Ticket deleted" }
  end

  private

  def set_ticket
    @ticket = Ticket.find_by(id: params[:id])
    return if @ticket

    render json: { error: "Ticket not found" }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :user_id)
  end
end
