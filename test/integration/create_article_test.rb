require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest 
 
 def setup
 # A user is needed in order to pass some of the tests
 @user = User.create(username: "TestUser",
               email: "testemail2@example.com",
               password:  "password")
 @category1 = Category.new(name: "Nonsense") 
 @category2 = Category.new(name: "Testing") 
 @category3 = Category.new(name: "Testing2") 
 end

 test "get article form and create article" do
    # No access to session hash in integration tests, so we use the sign in 
    # helper method in the test_helper.rb file.
    # Also, the password must explicitly be provided because when the user is created, the 
    # password is turned into a hash digest, so if we post to a link without 
    # providing the password, the password (would not match each other?)   
   sign_in_as(@user, "password")
   
   # Verify the nw article path is valid
   get new_article_path
   
   # Arrive at the form
   assert_template 'articles/new'
   
   # Post the form, confirm article was added, andd redirected appropriately
   assert_difference 'Article.count', 1 do
    post_via_redirect articles_path, article: {title: "How about this test",
                                      description: "Testing New Article",
                                      categories: [@category1, @category2, @category3] }
   end 

 end 
 
end

# https://github.com/EmmieA/alpha-blog/blob/master/test/integration/create_article_test.rb
