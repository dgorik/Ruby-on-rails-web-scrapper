require "test_helper"

class ContentPageTest < ActiveSupport::TestCase
  setup do
    @page = content_pages(:valid_page)
  end

  test "title can be blank or nil" do
    @page.title = nil
    assert @page.valid?, "Not valid when title is nil"

    @page.title = ""
    assert @page.valid?, "Not valid when title is blank"
  end

  test "url can be blank or nil" do
    @page.url = nil
    assert @page.valid?, "Not valid when url is nil"

    @page.url = ""
    assert @page.valid?, "Not valid when url is blank"
  end

  test "word_count can be blank or nil" do
    @page.word_count = nil
    assert @page.valid?, "Not valid when word_count is nil"

    @page.word_count = ""
    assert @page.valid?, "Not valid when word_count is blank"
  end

  test "table_of_contents can be blank or nil" do
    @page.table_of_contents = nil
    assert @page.valid?, "Not valid when table_of_contents is nil"

    @page.table_of_contents = ""
    assert @page.valid?, "Not valid when table_of_contents is blank"
  end

  test "top_10_words can be blank or nil" do
    @page.top_10_words = nil
    assert @page.valid?, "Not valid when top_10_words is nil"

    @page.top_10_words = ""
    assert @page.valid?, "Not valid when top_10_words is blank"
  end
end
