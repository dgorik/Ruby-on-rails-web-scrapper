require "test_helper"

class ContentPageTest < ActiveSupport::TestCase
  # Use the fixture record
  setup do
    @page = content_pages(:valid_page)
  end

  test "title should be present" do
    @page.title = nil
    assert_not @page.valid?, "Saved without a title"
  end

  test "url should be present" do
    @page.url = nil
    assert_not @page.valid?, "Saved without a url"
  end

  test "word_count should be present" do
    @page.word_count = nil
    assert_not @page.valid?, "Saved without a word_count"
  end

  test "table_of_contents should be present" do
    @page.table_of_contents = nil
    assert_not @page.valid?, "Saved without table_of_contents"
  end

  test "top_10_words should be present" do
    @page.top_10_words = nil
    assert_not @page.valid?, "Saved without top_10_words"
  end
end
