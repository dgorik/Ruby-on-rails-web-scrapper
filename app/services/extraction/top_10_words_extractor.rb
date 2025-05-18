module Extraction
  class Top10WordsExtractor

    STOP_WORDS = %w[the a an and or but to of in on at for with is are was were]

    def self.call(url)
        html = ::Url::Fetcher.fetch(url)
        return { error: "Failed to fetch URL" } unless html
        
        text = Nokogiri::HTML(html).at('body').text
        words = text
                 .gsub(/[^\w\s]/, '')
                 .split
                 .reject { |w| STOP_WORDS.include?(w) }

        words.tally
            .sort_by { |_word, count| -count }
            .first(10)
            .to_h
    rescue => e
        { error: "Top 10 Most Words count failed: #{e.message}" }
    end
   end
end

# in a pull request maybe specify that you could have added logic for exluding certain words from being counted (a,and, the etc)
# we are displaying words the way they appear on the page - we can make them all uppercase or lowercase if needed
