require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
 


  test "create user" do
    post '/users',
    params: {
     
    user_name:"hardikpandey",
    email: "har1@gmail.com",
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
             },

             headers: { Authorization: "Bearer #{my_token}"}
       pp JSON.parse(response.body)
    assert_response :success
  end

  test "get the user" do
    get '/users/1', headers: { Authorization: "Bearer #{my_token}"}
    JSON.parse(response.body)
    #  assert_match 'Users', response.body
    assert_response :success
    
  end

  # ===========get request user_by id=========
  test "should get by id" do
    get '/users/1',
    headers: { Authorization: "Bearer #{my_token}"}
    
    # pp my_token
    # pp response
    users = JSON.parse(response.body)
    pp users

    assert_equal "hardikpandey", users['user_name']
    assert_equal "har@gmail.com", users['email']
  end

  #  patch by id ==================
  test "user  update by id" do
    patch '/users/1',
    params: {
       user_name: "hardikpandey",
       email: "har@gmail.com",
       password:"Rohit@123",
       password_confirmation:"Rohit@123"
     },

    headers: {Authorization: "Bearer #{admin_token}"}
    res = JSON.parse(response.body)
    pp res
    assert_equal "hardikpandey", res["user"]['user_name']
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
    user_name:"hardikpandey",
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
    user_name:"hardikpandey",
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
    user_name:"",
    email: "har@gmail.com",
    password:"Hardik@123",
    password_confirmation:"Hardik@123"
    }
    puts JSON.parse(response.body)
   assert_response :success 
  end

  test "password cant be balnk" do
    post '/users',
    params: {
    user_name:"hardikpandey",
    email: "har@gmail.com",
    password:"",
    password_confirmation:"Hardik@123"
    }
    pp JSON.parse(response.body)
   assert_response :created
  end 

  test "Invalid email or password" do
    post '/login',
    params: {
        email:"har122@gmail.com",
       password:"Rohit@123",
    } 
    #  headers: { Authorization: "Baerer#{my_token}"}
      res = JSON.parse(response.body)
       assert_response :unauthorized 
       assert_equal "Invalid email or password", res["error"]
  end
  
  test " invalid token" do
    patch '/users/12',
    param: {
        email:"har122@gmail.com",
       password:"Rohit@123",
    } ,
    headers: { Authorization: "Baerer#{"eyJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImhhcmRpa3BhbmRleSIsImVtYWlsIjoiaGFyQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiSGFyZGlrQDEyMyIsInBhc3N3b3JkX2NvbmZpcm1hdGlvbiI6IkhhcmRpa0AxMjMifQ."}"}
    JSON.parse(json.response.body)

  end

  test "agent asigned successfully" do
    patch '/users/2/assign_role',
     
    params: {
         role:"agent"
    } ,
    headers: { Authorization: "Baerer#{admin_token}"}
    res = JSON.parse(response.body)

    
    assert_equal "agent", res["role"]
    assert_response :success
  end

  test "get all user to admin" do
    get '/users',
        headers: { Authorization: "Bearer #{admin_token}"}
    
    # pp my_token
    # pp response
    users = JSON.parse(response.body)
    pp users

    assert_equal "hardikpandey", users['user_name']
    assert_equal "har@gmail.com", users['email']

  end
  
  test " admin login here" do
    post '/login',
      params: {
          email:"sagar@gmail.com",
           password:"Sagar@123",
             },
       headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
    end


      test " agent login here" do
    post '/login',
      params: {
          email:"suraj@gmail.com",
           password:"Sagar@123",
             },
       headers: { Authorization: "Bearer #{agent_token}"}
    pp JSON.parse(response.body)
    assert_response :success
    end

   test " ticket aasiend to agent " do 
    patch '/tickets/7/assigne',
    params: {
         agent_id:3
    },
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
   end


    test " ticket not found " do 
    patch '/tickets/7/assigne',
    params: {
         agent_id:3
    },
    headers: { Authorization: "Bearer #{admin_token}"}
    res =JSON.parse(response.body)
    pp res
    assert_equal "3",  res["agent_id"]
    assert_response :success
   end
   
    test " agent not not found " do 
    patch '/tickets/7/assigne',
    params: {
         agent_id:3
    },
    headers: { Authorization: "Bearer #{my_token}"}
    res = JSON.parse(response.body)
    pp res
    assert_equal "3",  res["agent_id"]
    assert_response :success
   end
   
   test "ticket deleted successfully" do
    delete '/tickets/1',
    headers: { Authorization: "Bearer #{my_token}"}
    pp JSON.parse(response.body)
    assert_response :success
   end
   



   test "user soft delete" do
    delete '/users/1',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success

   end
   
   test "user not found" do
    delete '/users/4',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success

   end
























   test "user created here" do
    post '/users',
    params: {
      user_name: "sagar5",
      email: "sagar@gmail.com",
      password: "Sagar@123",
      password_confirmation: "Sagar@123"
    }
      res = JSON.parse(response.body)
      assert_response :success
      assert_equal "sagar5", res["user_name"]
      aseert_equal ""
   end



   
  

end
