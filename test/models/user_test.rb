require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(username: "test", email: "test@example.com", password: "testpassword")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.save
    @user2 = User.new(username: "test")
    assert_not @user2.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.username = "aa"
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be valid" do
    @user.email = "a"
    assert_not @user.valid?
  end

  test "email should be unique" do
    @user.save
    @user2 = User.new(email: "test@example.com")
  end

end