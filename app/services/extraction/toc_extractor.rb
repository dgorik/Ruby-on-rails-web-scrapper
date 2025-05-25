module Extraction
  class TocExtractor
    TOC_PATTERNS = %w[toc table-of-contents tableofcontents contents].freeze

    def self.call(html)
      doc = Nokogiri::HTML(html)
      container = find_valid_toc_container(doc)
      return [] unless container

      extract_items(container).to_json
    end

    private

    def self.find_valid_toc_container(doc)
      candidates = [
        doc.at_css('#toc'),
        doc.at_css('.toc'),
        doc.at_css('#table-of-contents'),
        doc.at_css('.table-of-contents')
      ].compact

      TOC_PATTERNS.each do |pattern|
        candidates << doc.at_css("[id*='#{pattern}']") if doc.at_css("[id*='#{pattern}']")
        candidates << doc.at_css("[class*='#{pattern}']") if doc.at_css("[class*='#{pattern}']")
      end

      navs = doc.css('nav').select do |nav|
        nav['role'] == 'navigation' || (nav['class'] && nav['class'].downcase.include?('toc'))
      end
      candidates.concat(navs)

      candidates.uniq!
      candidates.compact!

      candidates.find { |c| valid_toc?(c) }
    end

    def self.valid_toc?(container)
      list = container.at_css('ul, ol')
      return false unless list

      list.css('li').any? { |li| li.at_css('a[href^="#"]') }
    end

    def self.extract_items(container)
      container.css('a[href^="#"]').map do |link|
        {
          title: link.text.strip,
          depth: link.ancestors('ul, ol').count,
        }
      end
    end
  end
end



# This class extracts a structured Table of Contents (TOC) from an HTML document.

# It detects and parses TOC containers based on common patterns in IDs, class names, and semantic tags.
# The resulting list of TOC entries (each with a title and depth level) is returned as JSON.

# How it works:
# - Parses the HTML string with Nokogiri to create a document object.
# - Finds a valid TOC container element by searching in this order:
#   - Elements with common TOC IDs or classes such as '#toc' or '.table-of-contents'.
#   - Elements whose ID or class includes patterns like "toc" or "contents".
#   - <nav> elements with role="navigation" or classes including "toc".
# - Removes duplicates and nil elements from the candidate list.
# - Validates each candidate container to ensure it contains a list with at least one <a>.
# - Returns the first container that passes validation.
# - Extracts TOC items by:
#   - Finding all links pointing to in-page anchors.
#   - Capturing each link’s text content as the 'title'.
#   - Calculating 'depth' based on the number of ancestor <ul> or <ol> elements (reflecting TOC hierarchy).
# - Outputs a JSON array of objects with 'title' and 'depth'.

# Side note:
# This is approach that works best with clean, semantic HTML.
# - It assumes TOC containers follow relatively common naming conventions.
# - Only in-page anchor links (those with href="#...") are considered TOC items.

# In production, this logic could be extended to:
# - Support multiple valid containers per page (currently returns only the first valid one).
# - Tailor the logic to work with a specific website’s structure (for example websites that have TOC appear only after a Javascript script runs)

# Encapsulating this logic in its own class makes it easier to maintain.
# Future enhancements (e.g. supporting multiple formats or languages) can be added here without touching the rest of the app.
