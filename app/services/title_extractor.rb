class TitleExtractor
  require 'open-uri'
  require 'nokogiri'

  def self.fetch(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    doc.title
  rescue => e
    Rails.logger.error "Title extraction failed: #{e.message}"
    nil  # Return nil if failed
  end
end