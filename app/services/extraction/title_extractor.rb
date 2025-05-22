module Extraction
  class TitleExtractor
    def self.call(html)
      doc = Nokogiri::HTML(html)
      title = doc.title
      
      if title.nil? || title.strip.empty?
        { error: "Failed to fetch title" }
      else
        title
      end

    rescue => e
      { error: "Title extraction failed: #{e.message}" }
    end
  end
end

# create a seperate service that would validate if the link is good