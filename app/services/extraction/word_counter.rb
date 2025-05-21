module Extraction
  class WordCounter
    extend ActionView::Helpers::NumberHelper

    def self.call(html)
        text = Nokogiri::HTML(html).at('body').text
        words = text.split(/\W+/).reject(&:empty?)
        number_with_delimiter(words.size, delimiter: ",")
    rescue => e
        { error: "Word count failed: #{e.message}" }
    end
    end
end