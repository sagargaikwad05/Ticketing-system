class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]
 

  def index
    if status_param[:status].present?
      tickets = @current_user.tickets.where(status: status_param[:status])
    else
    render json: @current_user.tickets
   end
  end



  def show
    render json: @ticket
  end

  def create
    ticket = @current_user.tickets.new(ticket_params)
    if ticket.save
      render json: ticket, status: :created 
     else
      render json: { errors: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages}, status: :unprocessable_entity
    end
  end

  

  def destroy
    @ticket.destroy
    render json: { message: "Ticket deleted" }
  end

  def ticket_open
        topen = Ticket.where(status: "open")
        render json: topen
  end

      def ticket_awaiting_approval
        approval = Ticket.where(status: "awaiting_approval")
        render json: approval
      end

      def ticket_approved
        approved =Ticket.where(status: "approved")
        render json: approved
      end

    def  ticket_in_progress
       in_progress =Ticket.where(status: "in_progress")
       render json: in_progress
    end

    def  ticket_resolved
      resolvedt = Ticket.where(status: "resolved")
     render json: resolvedt
    end

    def ticket_closed
      closed =Ticket.where(status: "closed")
      render json: closed
    end



  private

  def set_ticket
    @ticket = current_user.tickets.find_by(id: params[:id])
   return if @ticket

    render json: { error: "Ticket not found" }, status: :not_found
  end


  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :user_id)
  end

  def status_param
    params.permit(:status)
  end

    def current_user
      @current_user
     end
  end

