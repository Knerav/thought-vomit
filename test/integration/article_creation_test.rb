require 'test_helper'

class ArticleCreationTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: "test", email: "test@example.com", password: "testpassword1")
    sign_in_as(@user)
  end

  test "new article creation" do
    get "/articles/new"
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "new article", description: "test article description" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "test", response.body
  end

  test "new article creation and reject invalid article" do
    get "/articles/new"
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " ", description: " " } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "new article creation and reject invalid description" do
    get "/articles/new"
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: "new article", description: " " } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "new article creation and reject invalid title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " ", description: "test article description" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end