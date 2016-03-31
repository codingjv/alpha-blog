require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
 
   test "get signup form and create user" do 
    
    # Verify path
    get signup_path
    
    # Verify signup form is presented
    assert_template 'users/new'
    
    # Posting the form andd arriving at user page 
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "testusertest", email: "testemail@example.com", password: "password"}
    end
 end 

end
 
# https://github.com/EmmieA/alpha-blog/blob/master/test/integration/user_signup_test.rb
