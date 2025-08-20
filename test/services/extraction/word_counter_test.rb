require "test_helper"

class Extraction::WordCounterTest < ActiveSupport::TestCase
  test "returns correct word count with delimiter" do
    html = "<html><body>This is a simple test.</body></html>"
    doc = Nokogiri::HTML(html)
    result = Extraction::WordCounter.call(doc)
    assert_equal 5, result
  end

  test "returns zero when body is empty" do
    html = "<html><body>   </body></html>"
    doc = Nokogiri::HTML(html)
    result = Extraction::WordCounter.call(doc)
    assert_equal 0, result
  end
end


