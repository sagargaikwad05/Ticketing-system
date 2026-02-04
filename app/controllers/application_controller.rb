class ApplicationController < ActionController::API
  before_action :authorize_request

  private
   


 def authorize_request
  header = request.headers['Authorization']
  token = header.split(' ').last if header

  decoded = JsonWebToken.decode(token)

  if decoded == :expired
    render json: { message: "Token expired. Please login again." }, status: :unauthorized
  elsif decoded.nil?
    render json: { message: "Invalid token" }, status: :unauthorized
  else
    @current_user = User.find(decoded[:user_id])
  end
end

def current_user
    @current_user 
end



end


