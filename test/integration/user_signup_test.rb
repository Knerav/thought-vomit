require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "user signup process" do
    get "/signup"
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "test", email: "test@example.com", password: "testpassword" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "test", response.body
  end

  test "user signup process and reject invalid signup" do
    get "/signup"
    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: " ", email: " ", password: " " } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "user signup process and reject invalid username" do
    get "/signup"
    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: " ", email: "test@example.com", password: "testpassword" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "user signup process and reject invalid email" do
    get "/signup"
    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "test", email: " ", password: "testpassword" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end