require "test_helper"

class TicketsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test " create user ticket " do
    post '/tickets',
    params: {
      title: "new ticket",
      description: "  new ticket screen is not working",
      status: "open"
    },
    headers: { Authorization: "Bearer #{my_token}"}
    # headers: {"Authorization" => "Bearer#{"my_""}
    #  pp response.body
     pp JSON.parse(response.body)
   #  pp ticket_body
    
   #   assert_equal "screen", tickets['title']
   
   #    assert_equal "screen is not working", tickets['description']
   #  pp JSON.parse(response.body)
    #  assert_response :created
  end

  test "get the tickets" do
    get '/tickets',
    headers: { Authorization: "Bearer #{my_token}"}
    JSON.parse(response.body)
    assert :success

  end

  test "get the ticket by id" do
    get '/tickets/1',
     headers: { Authorization: "Bearer #{admin_token}"}
     JSON.parse(response.body)
     assert :success
  end

  test "update the ticket by id" do
    patch '/tickets/1',
    params: {
      title: "charger",
    description: "charger is not working",
    status: "open"
    },
    headers: { Authorization: "Bearer #{admin_token}"}

      # pp @response.body
      # pp tres = @response.body
        pp  tres = JSON.parse(response.body)
    # pp tres
    # assert_equal "charger", tres["title"]
    # assert_equal "charger is not working", tres["description"] 
    # assert_equal "open", tres["status"]
    # assert_response :success

  end

  test "delete  the tickets" do
    delete '/tickets/1',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp res = JSON.parse(response.body)
   
    
  end

  test "ticket not found for get" do
   get '/tickets/15',
   headers: { Authorization: "Bearer#{admin_token}"}
   JSON.parse(response.body)
   

  end

  test "tickets not found for update" do 
    patch '/tickets/1',
    params: {
       title: "screen5",
       description: "screen is not working",
       status: "open"
    }, 
    headers: { Authorization: "Baerer#{admin_token}"}
    pp admin_token
   pp tres = JSON.parse(response.body)
    pp "======================"
    assert_equal "screen5", tres["title"]
    assert_equal "screen is not working", res["description"]
    assert_equal "open", res["status"]
    assert_nil tres
  end

  test "title must be present" do
    post '/tickets',
   params: {
    title: "",
    description: " screen is not working",
    status: "closed"
   },
     headers: { Authorization: "Bearer #{admin_token}"}
    
     pp response.body
     tickets = JSON.parse(response.body)
      assert :success
  end


  test "description must be present" do
    post '/tickets',
   params: {
    title: "screen",
    description: "",
    status: "closed"
   },
     headers: { Authorization: "Bearer #{admin_token}"}
    
     pp response.body
     tickets = JSON.parse(response.body)
     assert :success
  end

  test "invalid user..." do
    get '/tickets',
    headers: { Authorization: "Bearer#{"eyJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImhhcmRpa3BhbmRleSIsImVtYWlsIjoiaGFyQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiSGFyZGlrQDEyMyIsInBhc3N3b3JkX2NvbmZpcm1hdGlvbiI6IkhhcmRpa0AxMjMifQ."}"}
   res = JSON.parse(response.body)
    assert_nil res
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

  test " ticket aasiend admin only  " do 
    patch '/tickets/7/assigne',
    params: {
         agent_id:3
    },
       headers: { Authorization: "Bearer#{"eyJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImhhcmRpa3BhbmRleSIsImVtYWlsIjoiaGFyQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiSGFyZGlrQDEyMyIsInBhc3N3b3JkX2NvbmZpcm1hdGlvbiI6IkhhcmRpa0AxMjMifQ."}"}

    pp JSON.parse(response.body)
    assert_response :success
  end


  test " ticket not found " do 
    patch '/tickets/7/assigne',
    params: {
         agent_id:3
    },
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end
   
  test " assign agent " do 
    patch '/tickets/7/assigne',
    params: {
      agent_id: 3
    },
    headers: { Authorization: "Bearer #{admin_token}"}
    # pp response.body
    res = JSON.parse(response.body)
    pp res
    # assert_equal "3", res["agent_id"]
    # assert_response :success
  end
   
  test "ticket deleted successfully" do
    delete '/tickets/1',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end

  test "tickets get by status" do
   get '/open',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end

  test "unassigned tickets" do
   get'/unassigned',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end

  test "status updated" do
    patch '/tickets/2',
    params: {
      status: "approved"
    },
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end

  test "agent can see there assigned ticket" do
    get '/my_assigned',
    headers: { Authorization: "Bearer #{admin_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end
 
  test "invalid token  ! agent access only" do
    get '/my_assigned',
     headers: { Authorization: "Bearer#{"eyJhbGciOiJub25lIn0.eyJ1c2VybmFtZSI6ImhhcmRpa3BhbmRleSIsImVtYWlsIjoiaGFyQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiSGFyZGlrQDEyMyIsInBhc3N3b3JkX2NvbmZpcm1hdGlvbiI6IkhhcmRpa0AxMjMifQ."}"}
    pp JSON.parse(response.body)
    assert_response :not_found
  end

  test "user can see there ticket" do
   get '/my_tickets', 
    headers: { Authorization: "Bearer #{my_token}"}
    pp JSON.parse(response.body)
    assert_response :success
  end 
end
