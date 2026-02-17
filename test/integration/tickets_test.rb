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
     pp response.body
     tickets = JSON.parse(response.body)
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
     headers: { Authorization: "Bearer #{my_token}"}
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
    headers: { Authorization: "Bearer #{my_token}"}
       pp  tres = JSON.parse(response.body)
    # pp tres
    assert_equal "charger", tres["title"]
    assert_equal "charger is not working", tres["description"] 
    assert_equal "open", tres["status"]

  end

  test "delete  the tickets" do
    delete '/tickets/1',
    headers: { Authorization: "Bearer #{my_token}"}
   pp res = JSON.parse(response.body)
    
  end

  test "ticket not found for get" do
   get '/tickets/15',
   headers: { Authorization: "Bearer#{my_token}"}
   JSON.parse(response.body)
   

  end

  test "tickets not found for update" do 
    patch '/tickets/15',
    params: {
       title: "charger",
       description: "charger is not working",
       status: "open"
    }, 
    headers: { Authorization: "Baerer#{my_token}"}
   pp tres = JSON.parse(response.body)
    pp "======================"
    assert_equal "charger", tres["title"]
    assert_equal "charger is not working", res["description"]
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
     headers: { Authorization: "Bearer #{my_token}"}
    
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
     headers: { Authorization: "Bearer #{my_token}"}
    
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

  
  







  
end
