
    class TicketsController < ApplicationController
  # Logic to view own tickets
  def index
    @tickets = current_user.tickets
    render json: @tickets
  end

  # Logic to create a ticket
  def create
    @ticket = current_user.tickets.build(ticket_params)
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end

