require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  
	 should belong_to(:user)
	 should belong_to(:friend)

	 test "that creatinga friendship works without raising an exception " do 
	 	assert_nothing_raised do
	 		UserFriendship.create user: users(:patar), friend: users(:patar2)
	 	end
	 end


	 
  test "that creating a fri based on user id and friend id works" do
    UserFriendship.create user_id: users(:patar).id, friend_id: users(:patar2).id
        assert users(:patar).friends.include?(users(:patar2))

  end


	 

end
