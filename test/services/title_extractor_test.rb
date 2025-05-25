require "test_helper"

class Extraction::TitleExtractorTest < ActiveSupport::TestCase
  test "returns page title when present and not blank" do
    html = "<html><head><title>My Page Title</title></head><body></body></html>"
    result = Extraction::TitleExtractor.call(html)
    assert_equal "My Page Title", result
  end

  test "returns fallback message when title is blank" do
    html = "<html><head><title>   </title></head><body></body></html>"
    result = Extraction::TitleExtractor.call(html)
    assert_equal "No title for this page", result
  end
end


#basic unit test and for more complex applications we can add checks for nil title or when title doesn't exist 