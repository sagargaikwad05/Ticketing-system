require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
 


  test "create user" do
    post '/users',
    params: {
    username:"hardikpandey",
    email: "har@gmail.com",
    password:"Hardik@123",
    password_confirmation:"Hardik@123"
    }

    # headers: {'Authorization': }
   #  pp response
   pp JSON.parse(response.body)
   assert_response :created
   
  end
  test "user login here" do
    post '/login',
    params: {
       email:"har@gmail.com",
       password:"Hardik@123",
       
       
    }


    # headers: {'Authorization'=>{Bearer =>token}}
    pp JSON.parse(response.body)
    assert_response :success
  end

  test "get the user" do
    get '/users', headers: { Authorization: "Bearer #{my_token}"}
    JSON.parse(response.body)
    # assert_match 'Users', response.body
  end

  # ===========get request user_by id=========
  test "should get by id" do
    get '/users/1',
    headers: { Authorization: "Bearer #{my_token}"}
    
    # pp my_token
    # pp response
    users = JSON.parse(response.body)
    pp users

    assert_equal "hardikpandey", users['username']
    assert_equal "har@gmail.com", users['email']
  end

  #  patch by id ==================
  test "user  update by id" do
    patch '/users',
    params: {
       username: "hardikpandey",
       email: "har@gmail.com",
       password:"Rohit@123",
       password_confirmation:"Rohit@123"
     },

    headers: {Authorization: "Bearer #{my_token}"}
    res = JSON.parse(response.body)
    pp res
    assert_equal "hardikpandey", res["user"]['username']
    assert_equal "har@gmail.com", res["user"]['email']
  end
  
  test " delete user by id" do 
    delete '/user/1',
    headers: { Authorization: "Bearer #{my_token}"}
  end
  
    #  ============================================================================
  test "email id should be unique" do
       post '/users',
    params: {
    username:"hardikpandey",
    email: "har@gmail.com",
    password:"Hardik@123",
    password_confirmation:"Hardik@123"
    }
    pp JSON.parse(response.body)
   assert_response :created

  end
      

  test " paassword ,must include uppercase, lowercase, number, and special character" do
   post '/users',
    params: {
    username:"hardikpandey",
    email: "har@gmail.com",
    password:"hardik@123",
    password_confirmation:"hardik@123"
    }
    pp JSON.parse(response.body)
   assert_response :created
  end


  test "username is must be present" do
   post '/users',
   params: {
    username:"",
    email: "har@gmail.com",
    password:"Hardik@123",
    password_confirmation:"Hardik@123"
    }
    pp JSON.parse(response.body)
   assert_response :success 
  end

  test "password cant be balnk" do
    post '/users',
    params: {
    username:"hardikpandey",
    email: "har@gmail.com",
    password:"",
    password_confirmation:"Hardik@123"
    }
    pp JSON.parse(response.body)
   assert_response :created
  end 

  test "Invalid email or password" do
    post '/login',
    param: {
        email:"har122@gmail.com",
       password:"Rohit@123",
    } ,
    headers: { Authorization: "Baerer#{my_token}"}
    JSON.parse(json.response.body)
  end
  
  test " invalid token" do
    patch '/users/12',
    aram: {
        email:"har122@gmail.com",
       password:"Rohit@123",
    } ,
    headers: { Authorization: "Baerer#{"eyJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImhhcmRpa3BhbmRleSIsImVtYWlsIjoiaGFyQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiSGFyZGlrQDEyMyIsInBhc3N3b3JkX2NvbmZpcm1hdGlvbiI6IkhhcmRpa0AxMjMifQ."}"}
    JSON.parse(json.response.body)

  end

   
  

end
