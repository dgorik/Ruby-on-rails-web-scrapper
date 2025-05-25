require "test_helper"

class Extraction::TocExtractorTest < ActiveSupport::TestCase
  test "returns TOC items when a valid TOC is present" do
    html = <<~HTML
      <html>
        <body>
          <div id="toc">
            <ul>
              <li><a href="#section1">Section 1</a></li>
              <li><a href="#section2">Section 2</a></li>
            </ul>
          </div>
        </body>
      </html>
    HTML

    result = Extraction::TocExtractor.call(html)
    expected = [
      { title: "Section 1", depth: 1 },
      { title: "Section 2", depth: 1 }
    ].to_json

    assert_equal expected, result
  end

  test "returns an empty array when no valid TOC is found" do
    html = <<~HTML
      <html>
        <body>
          <div class="content">
            <p>No table of contents here</p>
          </div>
        </body>
      </html>
    HTML

    result = Extraction::TocExtractor.call(html)
    assert_equal [].to_json, result
  end
end


