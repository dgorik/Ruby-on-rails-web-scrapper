module Extraction
  class TocExtractor
    # Common patterns to identify TOC containers
    TOC_PATTERNS = %w[toc table-of-contents tableofcontents contents].freeze

    # Main interface - extracts TOC items from HTML fragment
    # @param toc_content [String] HTML fragment containing a TOC
    # @return [Array<Hash>] Structured TOC items
    def self.call(html)
      doc = Nokogiri::HTML(html)
      toc_container = find_toc_container(doc)
      return [] unless toc_container
      
      extract_toc_items(toc_container).to_json
    end
    
    private
    
    # Finds the TOC container element
    # @param doc [Nokogiri::HTML::Document]
    # @return [Nokogiri::XML::Element, nil]
    def self.find_toc_container(doc)
      # 1. Check explicit IDs/classes first
      container = doc.at_css('#toc, .toc, #table-of-contents, .table-of-contents')
      return container if container
      
      # 2. Search for TOC patterns in IDs/classes
      TOC_PATTERNS.each do |pattern|
        container = doc.at_css("[id*='#{pattern}'], [class*='#{pattern}']")
        return container if container
      end
      
      # 3. Check semantic nav elements
      doc.css('nav').find do |nav|
        nav['role'] == 'navigation' || 
        (nav['class'] && nav['class'].downcase.include?('toc'))
      end
    end
    
    # Extracts structured items from TOC container
    # @param container [Nokogiri::XML::Element]
    # @return [Array<Hash>]
    def self.extract_toc_items(container)
      container.css('a[href]').each_with_object([]) do |link, items|
        href = link['href'].to_s
        next if href.empty?
        
        items << {
          title: link.text.strip,
          depth: calculate_depth(link),
          href: href,
          fragment: href.start_with?('#') ? href[1..-1] : nil
        }
      end
    end
    
    # Calculates nesting depth of a TOC item
    # @param element [Nokogiri::XML::Element]
    # @return [Integer]
    def self.calculate_depth(element)
      element.ancestors('ul, ol').count
    end
  end
end