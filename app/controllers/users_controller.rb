class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:create, :login]

  def index
    users = User.all
    render json: {
      users_count: users.count,
      users: users.as_json(except: [:password_digest])
    }
  end

  def show
    render json: @user.as_json(
      except: [:password_digest],
      # include: :tickets
    )
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: {
        message: "User created successfully",
        user: user.as_json(except: [:password_digest])
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        message: "user updated successfully",
        user: @user.as_json(except: [:password_digest])
      }
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully" }
  end

  def login
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        message: "Login successful",
        token: token
      }
    else
      render json: {
        message: "Invalid email or password"
      }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    render json: { error: "User not found" }, status: :unprocessable_entity
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end