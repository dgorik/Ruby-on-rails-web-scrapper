class PageAnalyzer
  def self.call(url)
  
    return { error: "Invalid URL format" } unless Url::UrlValidator.valid?(url)

    html = Url::Fetcher.fetch(url)
    return html if html.is_a?(Hash) && html[:error]

    title = Extraction::TitleExtractor.call(html)
    return title if title.is_a?(Hash) && title[:error]

    toc = Extraction::TocExtractor.call(html)
    return toc if toc.is_a?(Hash) && toc[:error]
    
    cleaned_doc = Html::DocumentCleaner.document_cleaner(html)

    word_count = Extraction::WordCounter.call(cleaned_doc)
    return word_count if word_count.is_a?(Hash) && word_count[:error]

    top_words = Extraction::Top10WordsExtractor.call(cleaned_doc)
    return top_words if top_words.is_a?(Hash) && top_words[:error]

    {
      title: title,
      url: url,
      table_of_contents: toc,
      word_count: word_count,
      top_10_words: top_words
    }

  rescue => e
    { error: "Failed to analyze: #{e.message}" }
  end
end

# This service handles analyzing a web page from a given URL.
# It validates the URL, fetches the HTML, extracts the title and table of contents,
# cleans the HTML, counts words, and finds the top 10 words.
# If any step fails, it returns an error message.

# Why this matters:
# Keeping all analysis steps in one service makes the code organized and easy to maintain.
# It also helps catch errors early and keeps the controllers simple by moving the heavy work here.
