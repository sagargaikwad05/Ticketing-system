class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:create, :login]

  def index
    users = User.all
    render json: { users_count: users.count, users: users.as_json(except: [:password_digest])
    }
  end

  def show
    pp "==============helo============s"
    pp @current_user
      render json: @current_user.as_json( except: [:password_digest], )
  end




  def create
    user = User.new(user_params)

    if user.save
      render json: { message: "User created successfully",user: user.as_json(except: [:password_digest])
                    }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def assign_role
   if @current_user.admin?

    user = User.find_by(id: params[:id])

    
      if user.update(set_agent_params)

         render json: { message: "Role updated successfully", user: user }
    else
      render json: { error: "User not found" }
    end

   else
    render json: { error: "Admin only" }
   end
  end





  def update
   
  
    if @current_user.update(user_params)

      render json:{ message: "user updated successfully", 
                     user: @current_user.as_json(except: [:password_digest])}
    else
      # binding.pry
      render json: { errors: @current_user.errors.full_messages.join(',') }, status: :unprocessable_entity
    end
  end



 def destroy
   if @current_user.role == "admin"   # here checlk the user is admin

    user = User.find_by(id: params[:id])  #then find by id 

    if user
      if user.is_active  # if the is_active true then  it will update
        user.update(is_active: false)  # if done 
        render json: { message: "User deactivated successfully" } #it wil render success fully msg
      else
        render json: { message: "User already inactive" }  # if the user is false that time it will show 
      end
    else
      render json: { error: "User not found" }, status: :not_found  #if the user not found  by _id
    end

  else
    render json: { error: "Admin access only" }, status: :forbidden  # if the role is not admin  g
  end
 end

      


  def login
    # user = User.find_by(email: user_params[:email].downcase)
      user = User.find_by(email: user_params[:email].downcase)
     
    if user&.authenticate(params[:password])
   
     if user.is_active || !user.is_deleted
      token = JsonWebToken.encode(user_id: user.id)

      render json: { message: "Login successful", token: token }
     else
      render json: { message: "Invalid email or password"}, status: :unauthorized
     end
   end
  end


  private







  def set_user
     return if @current_user

    render json: { error: "User not found" }, status: :unprocessable_entity
  end
  
  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation, :role)
  end

  def update_user_params
    params.permit(:user_name, :email, :password)
  end

  def set_agent_params
    params.permit(:role)
  end
end