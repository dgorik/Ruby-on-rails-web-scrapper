module Extraction
  class TocExtractor
    def self.call(url)
      html = ::Url::Fetcher.fetch(url)
      return { error: "Failed to fetch URL" } unless html
      
      doc = Nokogiri::HTML(html)
      headings = doc.css('h1, h2, h3').map { |h| { level: h.name, text: h.text } }
      { toc: headings }
    rescue => e
      { error: "TOC extraction failed: #{e.message}" }
    end
  end
end