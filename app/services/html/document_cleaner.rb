require 'nokogiri'
module Html
  class DocumentCleaner
    UNWANTED_SELECTORS = %w[
      script style link meta head
      nav .navigation #navigation
      footer .footer #footer
      .sidebar #sidebar aside
      .menu #menu .nav
      .advertisement .ads #ads
      .social-links .social-media
      noscript
    ].freeze

    UNWANTED_ROLES = %w[
      navigation banner contentinfo
    ].freeze

    # Cleans an HTML string and returns a Nokogiri document
    def self.document_cleaner(html)
      doc = Nokogiri::HTML(html)

      # Remove unwanted elements by selector
      UNWANTED_SELECTORS.each do |selector|
        doc.css(selector).remove
      end

      # Remove elements by ARIA roles
      UNWANTED_ROLES.each do |role|
        doc.css(%([role="#{role}"])).remove
      end

      doc
    end
  end
end
