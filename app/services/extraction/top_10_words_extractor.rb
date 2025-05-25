module Extraction
  class Top10WordsExtractor
    
    STOP_WORDS = %w[
      i me my myself we our ours ourselves you you're you've you'll you'd your yours yourself
      yourselves he him his himself she she's her hers herself it it's its itself they them
      their theirs themselves what which who whom this that that'll these those am is are
      was were be been being have has had having do does did doing a an the and but if or
      because as until while of at by for with about against between into through during
      before after above below to from up down in out on off over under again further then
      once here there when where why how all any both each few more most other some such no
      nor not only own same so than too very s t can will just don don't should should've
      now d ll m o re ve y ain aren aren't couldn couldn't didn didn't doesn doesn't hadn
      hadn't hasn hasn't haven haven't isn isn't ma mightn mightn't mustn mustn't needn needn't
      shan shan't shouldn shouldn't wasn wasn't weren weren't won won't wouldn wouldn't
    ].freeze

    def self.call(doc)
      body = doc.at('body') || doc
      text = body.text.gsub(/\s+/, ' ').strip
      text = text.split.select { |word| word.length >= 3 }.join(' ')

      words = text
                .gsub(/[^\w\s]/, '')
                .gsub(/\b\d+\b/, '')
                .split
                .map(&:downcase)
                .reject { |word| STOP_WORDS.include?(word) }

      words
        .tally
        .sort_by { |_word, count| -count }
        .first(10)
        .to_h

    rescue => e
      { error: "Top 10 word extraction failed: #{e.message}" }
    end

  end
end


# This class extracts the top 10 most frequent words from an HTML document.

# The list of stop words is based on the NLTK English stop words corpus,
# which includes common English words that usually carry little meaning.

# How it works:
# - It locates the <body> element in the HTML document (or uses the whole doc if no body).
# - Extracts all text content and replaces multiple spaces/newlines with a single space, then trims.
# - Splits the text into individual words, removes any shorter than 3 characters to reduce noise, and stores the result in an array.
# - Removes punctuation and standalone numbers completely.
# - Converts all words to lowercase so counting is case-insensitive.
# - Removes common stop words like "the", "and", etc., based on the STOP_WORDS list.
# - Uses tally (a built in method in Ruby) to to count the frequency of each word in an array 
# - Returns the top 10 most frequent words along with their counts.


# Side note:
# This is a simple way to find the most frequently used words on a page, but it has some limitations:
# - Contractions like “don’t” are included in the stop words list and therefore removed entirely,
#   so they don’t appear in the results at all.
# - The method assumes the text is English and may not handle accented characters or other languages properly.
# - Numbers are completely removed, even if they could be important in some contexts (e.g., “2024”).
# - Very short words (under 3 characters) are filtered out, which might exclude some meaningful terms.
# - Different forms of words, such as “run” and “running” are counted as separate words.


# In production, this logic will likely need to be adjusted based on:
# - Whether to include more or fewer stop words
# - Whether to keep numbers or filter them out
# - Whether to include very short words or not

# Also, support for languages other than English might needed to be considered.