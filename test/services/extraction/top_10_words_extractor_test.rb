require "test_helper"

class Extraction::Top10WordsExtractorTest < ActiveSupport::TestCase
  test "extracts top words ignoring common stop words" do
    html = "<html><body>Basecamp Basecamp Highrise Highrise Signal Signal Signal project communication communication the and but</body></html>"
    doc = Nokogiri::HTML(html)
    result = Extraction::Top10WordsExtractor.call(doc)

    expected = {
      "signal" => 3,
      "basecamp" => 2,
      "highrise" => 2,
      "communication" => 2,
      "project" => 1
    }

    expected.each do |word, count|
      assert_equal count, result[word]
    end
  end
  test "returns empty hash if only stop words present" do
    html = "<html><body>the and but or if</body></html>"
    doc = Nokogiri::HTML(html)
    result = Extraction::Top10WordsExtractor.call(doc)
    assert_equal({}, result)
  end
end
