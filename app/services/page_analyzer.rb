class PageAnalyzer
  def self.call(url)

    unless Url::UrlValidator.valid?(url)
        return { error: "Invalid URL format" }
    end

    html = URI.open(url).read #explain why we are doing it like this

    title = Extraction::TitleExtractor.call(html)

    # clean_html = Url::Fetcher.fetch(url)

    # also think about removing html clener entirely

    table_of_contents = Extraction::TocExtractor.call(html)
    word_count = Extraction::WordCounter.call(html)
    top_10_words = Extraction::Top10WordsExtractor.call(html)

    result = {
      title: title,
      url: url,
      table_of_contents: table_of_contents,
      word_count: word_count,
      top_10_words: top_10_words,
      
    }

  rescue => e
    { error: "Failed to analyze: #{e.message}" }
  end
end