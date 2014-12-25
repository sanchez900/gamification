require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
 context "#new" do
 	context "when not logged in" do
 		should "redirect to the login page" do
 			get :new
 			assert_response :redirect
 		end
 	end
 end
end
