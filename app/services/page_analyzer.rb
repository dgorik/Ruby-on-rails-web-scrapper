class PageAnalyzer
  def self.call(url)

    title = Extraction::TitleExtractor.call(url)
    table_of_contents = Extraction::TocExtractor.call(url)
    word_count = Extraction::WordCounter.call(url)
    top_10_words = Extraction::Top10WordsExtractor.call(url)

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
    # puts "This is my title: #{title}"
    # puts "This is my content: #{table_of_contents}"
    # puts "This is my content: #{word_count}"
    # puts "This is my content: #{top_10_words}"