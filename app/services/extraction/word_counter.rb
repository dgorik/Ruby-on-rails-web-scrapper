module Extraction
  class WordCounter
    extend ActionView::Helpers::NumberHelper

    def self.call(doc)
      text = doc.at('body').text
      words = text.split(/\W+/).reject(&:empty?)
      number_with_delimiter(words.size, delimiter: ",")
    rescue => e
      { error: "Word count failed: #{e.message}" }
    end
  end
end


# This class counts the number of words in a cleaned HTML document.
# It:
# - Extracts all the text from the <body> tag
# - Splits the text into words using non-word characters (like punctuation or spaces) as separators
# - Removes any empty strings and stores the result in an array
# - Calculates the array’s length (the word count) and formats it nicely with commas (e.g., 1,234)
#
# If anything goes wrong during the process, it returns a user-friendly error message.

# Side note:
# This is a simple and fast way to estimate word count, but it has some quirks:
# - It splits contractions like “don’t” into two words: "don" and "t"
# - It doesn’t handle non-English characters or accents very well
# - It counts standalone numbers (like “123”) as words too

# In production, we would probably want to adjust this logic:
    # Based on whether there’s a need to support multiple languages or skip numbers if they’re not relevant.