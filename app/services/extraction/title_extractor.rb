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

# This class extracts the page title from an HTML document.

# How it works:
# - Parses the input HTML into a Nokogiri document.
# - Extracts the content of the <title> element.
# - Returns the title text if it exists and is not empty.
# - Returns a fallback string if the title is missing or blank.
# - Catches exceptions during parsing or extraction and returns a descriptive error.

# Why this matters:
# Encapsulating title extraction into it's own  class simplifies testing and debugging.
# It provides a clear interface for extracting page titles.

# In production, this logic could be extended to:
# - Handle alternative title sources such as <meta> tags.
# - Support extraction from dynamically generated content (e.g., is a title appears after JavaScript script loads and runs).