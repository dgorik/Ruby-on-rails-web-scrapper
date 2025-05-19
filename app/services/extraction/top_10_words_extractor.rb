module Extraction
  class Top10WordsExtractor

    STOP_WORDS = %w[
      a about above after again against all am an and any are aren't as
      at be because been before being below between both but by can't cannot
      could couldn't did didn't do does doesn't doing don't down during each
      few for from further had hadn't has hasn't have haven't having he he'd
      he'll he's her here here's hers herself him himself his how how's i
      i'd i'll i'm i've if in into is isn't it it's its itself let's me
      more most mustn't my myself no nor not of off on once only or other
      ought our ours ourselves out over own same shan't she she'd she'll she's
      should shouldn't so some such than that that's the their theirs them
      themselves then there there's these they they'd they'll they're they've this
      those through to too under until up very was wasn't we we'd we'll
      we're we've were weren't what what's when when's where where's which while
      who who's whom why why's with won't would wouldn't you you'd you'll
      you're you've your yours yourself yourselves
    ]

    def self.call(html)

      text = Nokogiri::HTML(html).at('body').text.gsub(/\s+/, ' ').strip #talk about this in PR

      text = text.split.select { |word| word.length >= 3 }.join(' ') #removing short words

      words = text
                .gsub(/[^\w\s]/, '') #remove punctuation
                .gsub(/\b\d+\b/, '') #remove standalone numbers
                .split
                .reject { |w| STOP_WORDS.include?(w.downcase) || STOP_WORDS.include?(w.upcase) }

      words
        .tally
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

#cite a source where you got stop words from

#mention that currently word extraction is case insensitive

