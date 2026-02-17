ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'json'

module ActiveSupport
  class TestCase
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

    def my_token
      set_user_login
      token = JSON.decode(response.body)["token"]
      # pp response.body
      # pp token
    end
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end