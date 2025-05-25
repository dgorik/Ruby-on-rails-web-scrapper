require "test_helper"

class Extraction::WordCounterTest < ActiveSupport::TestCase
  test "returns formatted word count for valid HTML body text" do
    html = "<html><body>Hello</body></html>"
    doc = Nokogiri::HTML(html)
    result = Extraction::WordCounter.call(doc)
    assert_equal "1", result
  end
end

#we can also add more tests for when the body is missing for example