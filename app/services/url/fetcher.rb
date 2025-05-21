require 'open-uri'
require 'nokogiri'

module Url
  class Fetcher
    TIMEOUT = 3 # seconds

    def self.fetch(url)
      # First validate the URL

      # Then attempt to fetch
      html = URI.open(url, read_timeout: TIMEOUT).read

      # clean_html = HtmlCleaner.fetch(html)
      
    rescue OpenURI::HTTPError
      { error: "Website returned an error" }
    rescue SocketError
      { error: "Couldn't connect to the server" }
    rescue Timeout::Error
      { error: "Request took too long" }
    rescue => e
      { error: "Failed to fetch: #{e.message}" }
    end
  end
end