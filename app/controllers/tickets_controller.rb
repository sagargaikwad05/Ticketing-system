class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]
  before_action :set_admin, only: [:unassigned, :ticket_assigned, :update, :destroy, :ticket_open, :ticket_approved, :ticket_in_progress, :ticket_resolved, :ticket_closed ]
 before_action :set_agent, only: [:my_assigned]

  def index
    if @current_user.s
  end



  def show
    render json: @ticket
  end

   def create
    pp "=========================="
    ticket = @current_user.tickets.new(ticket_params) 
    if ticket.save
      render json: {message: "ticket created successfully", ticket: ticket}, status: :created
    else
      render json: {errors: "ticket is not created"}, status: :unprocessable_entity
    end
  end 




  def update
    if @current_user.admin? || @current_user.agent?
       
      # @ticket = Ticket.find_by(id: params[:id])
     if @ticket.update(ticket_params)
      render json: @ticket
     else
      render json: { errors: " sorry ticket not found "}, status: :unprocessable_entity
     end
    else
      render json: {errors: "Admi and user access only " }, status: :forbidden
    end
  end
      


  def ticket_assigned
   unless @current_user.admin?
     return render json:{ message:"Admin access only"}, status: :forbidden
   end

    ticket = Ticket.find_by(id: params[:id])
    return render json: { message: " Ticket not found"}, status: :not_found unless ticket
  

    agent = User.find_by(id: params[:agent_id])
    return render json: { message: " agent not  found "}, status: :not_found unless agent

    if ticket.update(agent_id: params[:agent_id], status: :in_progress)
      render json: { message: "ticket assigned successfully", ticket: ticket}, status: :ok
    else
      render json: {message: ticket.errors.full_messages}, status: :unprocessable_entity
    end
 end


  

  def destroy
     if @current_user.admin?
      if @ticket.destroy
       render json: { message: "Ticket deleted" }
      else
        render json:{error: @ticket.errors.full_messages}, status: :not_found
      end
    else
      render json: { message: " Admin access only"}, status: :forbidden
   end
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

  def unassigned
    if @current_user.admin?
      tickets = Ticket.where(agent_id: nil)
     render json: tickets
     else
       render json: {errors: "Admin access only"}, status: :forbidden
    end
  end

  def update_status
      ticket = Ticket.find(params[:id])

     if ticket.update(status: params[:status])
          render json: ticket
      else
       render json: {errors: ticket.errors.full_messages}, status: :forbidden
     end
  end

  def all
      render json: Ticket.all
  end

  

  def  my_assigned
    pp @current_user
      if @current_user.agent?
       render json: Ticket.where(agent_id: @current_user.id)
      else
        render json: {errors: " agent acces only"}
      end
  end

  def my_tickets
    render json: @current_user.tickets
  end


  def check_assigned
    if @current_user.admin?
      tickets = Ticket.where.not(agent_id: nil)
     render json: tickets
     else
       render json: {errors: "Admin access only"}, status: :forbidden
     end
  end





  private

  def set_ticket
    @ticket = Ticket.find_by(id: params[:id])
    return if @ticket
      render json: { error: "Ticket not found" }, status: :not_found
  end


  def ticket_params
    params.permit(:title, :description, :status, :user_id, :priority)
  end

  def status_param
    params.permit(:status)
  end
   
  def set_admin
  return render json: {message: "Admin only"}, status: :forbidden unless @current_user.admin?
  end

  def

  def set_agent
    pp"Agent access only"
   return render json: {error: "Agent access only"}, status: :forbidden unless @current_user.agent?
  end
  

  def current_user
      @current_user
  end
end
