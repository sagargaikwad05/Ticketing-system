ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'json'

class ActiveSupport::TestCase
 
    def set_user_login
        post '/login',
      params: {
       email:"har@gmail.com",
       password:"Hardik@123",
      }
      
      # pp "Response body #{JSON.decode(response.body)}"
      #  JSON.decode(response.body)
        #  assert_response :success
    end
    def set_admin_login
        post '/login',
      params: {
       email:"sagar@gmail.com",
       password:"Sagar@123",
      }
    end
    def my_token
       set_user_login
       token = JSON.parse(response.body)["token"]
      # pp response.body
      # pp token
    end

    def set_admin_login
        post '/login',
      params: {
       email:"sagar@gmail.com",
       password:"Sagar@123",
      }
    end
      
    def admin_token
      set_admin_login
      token = JSON.parse(response.body)["token"]
    end


    def set_agent_login
       post '/login',
      params: {
       email:"suraj@gmail.com",
       password:"Sagar@123",
      }
    end


    def agent_token
      set_agent_login
      token = JSON.pasre(response.body)["token"]
    end
      




    # def ticket_current_user
    #  post '/tickets'
    #     {          
    #       title:"screen",
    #       description: "screen is  not working"
    #     }   
    #     pp "Response body #{response.body}"
    #     assert_response :success
    #   #  @current_user
    # end
      # def my_token
      #    set_user_login

      #      raise "Login failed: #{response.body}" if response.body.blank?

      #       JSON.decode(response.body)["token"]
      # end

      
    
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  
end