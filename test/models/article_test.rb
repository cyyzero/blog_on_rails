require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @article = @user.articles.build(title: "Title", content: "Content")
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "user id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "title should be present" do
    @article.title = "   "
    assert_not @article.valid?
  end

  test "title should be at most 100 characters" do
    @article.title = "a" * 101
    assert_not @article.valid?
  end
  
  test "content should be present" do
    @article.content = "   "
    assert_not @article.valid?
  end

  test "content should be at most 30000 characters" do
    @article.content = "a" * 30001
    assert_not @article.valid?
  end

  test "order should be most recent first" do
    assert_equal articles(:most_recent), Article.first
  end

end
