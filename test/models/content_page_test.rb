require "test_helper"

class ContentPageTest < ActiveSupport::TestCase
  # Use the fixture record
  setup do
    @page = content_pages(:valid_page)
  end

  test "fixture is valid" do
    assert @page.valid?, "The fixture should be valid"
  end

  test "title should be present" do
    @page.title = nil
    assert_not @page.valid?, "Title can't be blank"
  end

  test "url should be present" do
    @page.url = nil
    assert_not @page.valid?, "URL can't be blank"
  end

  test "word_count should be present" do
    @page.word_count = nil
    assert_not @page.valid?, "Word count can't be blank"
  end

  test "table_of_contents should be present" do
    @page.table_of_contents = nil
    assert_not @page.valid?, "Table of contents can't be blank"
  end

  test "top_10_words should be present" do
    @page.top_10_words = nil
    assert_not @page.valid?, "Top 10 words can't be blank"
  end

  test "word_count should be numeric string" do
    @page.word_count = "not_a_number"
    assert_not @page.valid?, "Word count should be a numeric string"
  end
end

