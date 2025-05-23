module Extraction
  class TitleExtractor
    def self.call(html)
      doc = Nokogiri::HTML(html)
      title = doc.title
      
      if title.nil? || title.strip.empty?
        "No title for this page"
      else
        title
      end

    rescue => e
      { error: "Title extraction failed: #{e.message}" }
    end
  end
end

# create a seperate service that would validate if the link is good

#ask a question if there is a page without a title, do you want to to render other info or do we want to return "cannot be fetched"