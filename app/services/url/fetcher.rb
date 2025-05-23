require 'open-uri'
require 'nokogiri'

module Url
  class Fetcher
    TIMEOUT = 3 # seconds

    def self.fetch(url)
      # First validate the URL

      # Then attempt to fetch
      html = URI.open(url, read_timeout: TIMEOUT).read

      html
      
    rescue OpenURI::HTTPError
      { error: "Website returned an error" } 
      # if you pass a link to a private google doc
    rescue SocketError
      { error: "Couldn't connect to the server" }
    rescue Timeout::Error
      { error: "Request took too long" }
    end
  end
end

# explain the difference between all these errors

# http://example..com - returns couldn't connect to the server

# https://docs.google.com/document/d/1HQLa-uqQ3BV2glVUNdQHgxdqxFs2AaE4lOHR29NR_nQ/edit?tab=t.0 - returns website returned an error





# # Responds at all (no DNS errors, no connection timeout)

# Returns a valid HTTP status (200 OK, etc.)

# Handles redirects, errors (404, 500, etc.)
