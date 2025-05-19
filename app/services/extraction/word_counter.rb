module Extraction
  class WordCounter
    def self.call(html)
        text = Nokogiri::HTML(html).at('body').text
        words = text.split(/\W+/).reject(&:empty?)
        word_counter = words.size 
    rescue => e
        { error: "Word count failed: #{e.message}" }
    end
    end
end