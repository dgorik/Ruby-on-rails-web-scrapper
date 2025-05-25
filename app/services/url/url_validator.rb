require 'uri'
require 'open-uri'

module Url
  class InvalidUrlError < StandardError; end

  class UrlValidator
    SUPPORTED_SCHEMES = ["http", "https"]

    def self.valid?(url)
      parse(url)
      true
    rescue InvalidUrlError
      false
    end

    def self.parse(url)
      raise InvalidUrlError, "URL can't be blank" if url.nil? || url.strip.empty?

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
  end
end



# This module uses Ruby’s built-in URI library to parse and validate URLs.

# Initially, a regex was used for validation but it failed on complex URLs like:
#   https://example.com:3000/path?query=1#section
#   https://sub.example.co.uk

# The current approach parses the URL and checks for:
# - Presence of a valid scheme (http or https)
# - A non-empty host/domain name
# - Proper overall URL format

# This validation only checks if the URL is correctly formed and syntactically valid.

# In production, this logic might be adapted to validate specific URL formats or constraints.
# For example, restricting URLs to a particular domain or path pattern:
#   Only allowing URLs starting with "https://37signals.com/jobs"