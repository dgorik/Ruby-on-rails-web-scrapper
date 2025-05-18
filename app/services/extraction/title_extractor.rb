module Extraction
  class TitleExtractor
    def self.call(url)
      html = ::Url::Fetcher.fetch(url)
      return { error: "Failed to fetch URL" } unless html
      
      doc = Nokogiri::HTML(html)
      { title: doc.title }
    rescue => e
      { error: "Title extraction failed: #{e.message}" }
    end
  end
end

# create a seperate service that would validate if the link is good