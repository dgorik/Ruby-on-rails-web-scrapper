class PageAnalyzer
  def self.call(url)
    # Step 1: Validate URL

    puts Url::UrlValidator.valid?(url)

    return { error: "Invalid URL format" } unless Url::UrlValidator.valid?(url)

    #maybe here we can return a url and if there is an error return that error message

    # Step 2: Fetch HTML from URL
    html = Url::Fetcher.fetch(url)
    return html if html.is_a?(Hash) && html[:error] # HTML fetch failure

    # Step 3: Extract components
    title = Extraction::TitleExtractor.call(html)
    return title if title.is_a?(Hash) && title[:error]


    cleaned_doc = Html::DocumentCleaner.document_cleaner(html)
    toc = Extraction::TocExtractor.call(cleaned_doc)
    return toc if toc.is_a?(Hash) && toc[:error]

    word_count = Extraction::WordCounter.call(cleaned_doc)
    return word_count if word_count.is_a?(Hash) && word_count[:error]

    top_words = Extraction::Top10WordsExtractor.call(cleaned_doc)
    return top_words if top_words.is_a?(Hash) && top_words[:error]

    # Step 4: Return structured result
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
