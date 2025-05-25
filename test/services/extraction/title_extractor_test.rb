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

  test "returns fallback message when title is missing" do
    html = "<html><head></head><body></body></html>"
    result = Extraction::TitleExtractor.call(html)
    assert_equal "No title for this page", result
  end
end
