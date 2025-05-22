# require 'nokogiri'

# module Url
#   class HtmlCleaner
#     def self.fetch(html)
#       doc = Nokogiri::HTML(html)
#       doc.search('script, style, iframe, embed, object, input, textarea, button, select').remove
#       doc.search('.hidden, .visually-hidden, .sr-only, .ad-container, .advertisement, .ads, 
#                   .nav, .navigation, .menu, .footer, .sidebar, .aside, .comments,
#                   .reference, table, .infobox, .navbox').remove
#       doc.css('*[style*="display:none"], *[style*="display: none"]').remove

#       doc.to_html
#     end

#     def self.title_fetch(html)
#       doc = Nokogiri::HTML(html)
#       title = doc.title
#     end
#   end
# end