require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty? 
  end


   test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty? 
  end


   test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty? 
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:patar).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty? 
  end


  test "A user profile should not have a space" do
    user = User.new(first_name: 'pat', last_name: 'sanc', email: 'pa@g.co')
    user.password = user.password_confirmation = 'poiuythfmaas'

    user.profile_name = "My profile with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")

  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'pat', last_name: 'sanc', email: 'pa@g.co')
    user.password = user.password_confirmation = 'poiuythfmaas'

    user.profile_name = 'patas_coco'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list " do 
    assert_nothing_raised do
      users(:patar).friends
    end
  end

  test "that creating friendship on a user works" do
    users(:patar).friends << users(:patar2)
    users(:patar).friends.reload
    assert users(:patar).friends.include?(users(:patar2))
  end

  test "that calling to_param on a user returns the profile_name" do
    assert_equal "patar", users(:patar).to_param
  end

end
