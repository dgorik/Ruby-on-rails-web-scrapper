require 'open-uri'
require 'nokogiri'

module Url
  class Fetcher
    TIMEOUT = 3

    def self.fetch(url)
      html = URI.open(url, read_timeout: TIMEOUT).read
      html
    rescue OpenURI::HTTPError
      { error: "Website returned an error" }
    rescue SocketError
      { error: "Couldn't connect to the server" }
    rescue Timeout::Error
      { error: "Request took too long" }
    end
  end
end


# This module takes the HTML from a URL using Ruby’s open-uri.

# It tries to fetch the page with a 3-second timeout.
# If something goes wrong, it catches these errors:
# - HTTPError: The site gave back an error (private Google doc for example or 404)
# - SocketError: Can’t connect to the server (incorrect hostname or non-existing domain)
# - Timeout::Error: The site took too long to respond

# In production, we might want:
# - Increase/decrease timeout depending on how slow/fast the server is
# - We can improve reliability by handling more error types, like 
    # SSL errors (when a site has certificate issues)
    # Redirects (when a URL automatically forwards to another page).
