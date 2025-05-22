require 'uri'
require 'open-uri'

module Url
  class InvalidUrlError < StandardError; end

  class UrlValidator
    SUPPORTED_SCHEMES = ["http", "https"]

    def self.valid?(url)
      uri = parse(url)
      # url_ok?(uri)
    rescue InvalidUrlError
      false
    end

    def self.parse(url)
      raise InvalidUrlError, "URL can't be blank" if url.nil? || url.strip.empty? 

      # mention why you can't realy on this alone on the client side

      uri = URI.parse(url)

      unless SUPPORTED_SCHEMES.include?(uri.scheme)
        raise InvalidUrlError, "Invalid scheme: '#{uri.scheme}'"
      end

      if uri.host.nil? || uri.host.strip.empty?
        raise InvalidUrlError, "Host is blank"
      end

      uri
    rescue URI::InvalidURIError => e
      raise InvalidUrlError, e.message
    end
    # def self.url_ok?(uri)
    #   open(uri,read_timeout: 5) { |response| response.status[0].to_i == 200 }
    # rescue OpenURI::HTTPError, SocketError, Errno::ECONNREFUSED, Errno::ETIMEDOUT
    #   false
    # end
  end
end


# talk about  Ruby’s built-in URI module 

#was doing a reg expression check at first but then noticed that those checks didn't validate url inputs below: 

#https://example.com:3000/path?query=1#section
#https://sub.example.co.uk

# Your current validation checks format and syntax — but the server might not exist or the URL might 404.

# Sending a real HTTP request (a HEAD or GET) to check the status code (like 200 OK) confirms the link is actually responding.

