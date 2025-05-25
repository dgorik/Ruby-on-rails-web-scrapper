require 'nokogiri'

module Html
  class DocumentCleaner
    UNWANTED_SELECTORS = %w[
      script style link meta head
      nav .navigation navigation
      footer .footer footer
      .sidebar sidebar aside
      .menu menu .nav
      .advertisement .ads ads
      .social-links .social-media
      noscript
    ].freeze

    UNWANTED_ROLES = %w[
      navigation banner contentinfo
    ].freeze

    def self.document_cleaner(html)
      doc = Nokogiri::HTML(html)

      UNWANTED_SELECTORS.each do |selector|
        doc.css(selector).remove
      end

      UNWANTED_ROLES.each do |role|
        doc.css(%([role="#{role}"])).remove
      end

      doc
    end
  end
end

# This module cleans up an HTML document by removing clutter.

# It uses Nokogiri to parse the HTML and then strips out common unwanted parts like:
# - Scripts, styles, meta tags, headers, footers, sidebars, menus, ads, and social links
# - Elements with certain ARIA roles like navigation, banners, and contentinfo

# This keeps only the main content, making further processing (like counting words or extracting most frequent words) more accurate.

# In production, this cleaning logic might be adjusted to:
# - Keep certain elements if needed (e.g., scripts required for dynamic content)
# - Remove additional selectors or roles specific to a website