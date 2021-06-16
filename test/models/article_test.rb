require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = Article.new(title: "test", description: "test description")
  end

  test "article should be valid" do
    assert_not @article.valid?
  end

  test "title should be present" do 
    @article.title = " "
    assert_not @article.valid?
  end

  test "title should be unique" do
    @article.save
    @article2 = Article.new(title: "test")
    assert_not @article2.valid?
  end

  test "description should be present" do 
    @article.description = " "
    assert_not @article.valid?
  end

  test "description should be unique" do
    @article.save
    @article2 = Article.new(description: "test description")
    assert_not @article2.valid?
  end

  test "title should not be too short" do
    @article.title = "a" * 5
    assert_not @article.valid?
  end

  test "title should not be too long" do
    @article.title = "a" * 101
    assert_not @article.valid?
  end

  test "description should not be too short" do
    @article.description = "a" * 9
    assert_not @article.valid?
  end

  test "description should not be too long" do
    @article.description = "a" * 1001
    assert_not @article.valid?
  end
end