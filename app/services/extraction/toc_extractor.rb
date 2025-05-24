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

    # Finds a TOC container that passes the validity checks
    def self.find_valid_toc_container(doc)
      # 1. Check explicit IDs/classes first
      candidates = [
        doc.at_css('#toc'),
        doc.at_css('.toc'),
        doc.at_css('#table-of-contents'),
        doc.at_css('.table-of-contents')
      ].compact

      # 2. Add containers found by TOC patterns in IDs/classes
      TOC_PATTERNS.each do |pattern|
        candidates << doc.at_css("[id*='#{pattern}']") if doc.at_css("[id*='#{pattern}']")
        candidates << doc.at_css("[class*='#{pattern}']") if doc.at_css("[class*='#{pattern}']")
      end

      # 3. Add nav elements with role or class indicating toc
      navs = doc.css('nav').select do |nav|
        nav['role'] == 'navigation' || (nav['class'] && nav['class'].downcase.include?('toc'))
      end
      candidates.concat(navs)

      # Remove duplicates and nils
      candidates.uniq!
      candidates.compact!

      # Return the first candidate passing validation
      candidates.find { |c| valid_toc?(c) }
    end

    # Validates container structure for TOC
    def self.valid_toc?(container)
      list = container.at_css('ul, ol')
      return false unless list

      list.css('li').any? { |li| li.at_css('a[href^="#"]') }
    end

    # Extract TOC items from validated container
    def self.extract_items(container)
      container.css('a[href^="#"]').map do |link|
        {
          title: link.text.strip,
          depth: link.ancestors('ul, ol').count,
          href: link['href'],
          fragment: link['href'][1..] # remove leading #
        }
      end
    end
  end
end
