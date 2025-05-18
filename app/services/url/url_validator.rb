require 'open-uri'
require 'nokogiri'

module Url
  class UrlValidator
    def self.valid?(url)
      # Basic checks
      return false if url.nil? || url.empty?
      
      # Must start with http:// or https://
      return false unless url.start_with?('http://', 'https://')
      
      # Simple regex check for basic URL format
      url.match?(%r{^https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(/\S*)?$})
    rescue
      false # Catch any unexpected errors
    end
  end
end