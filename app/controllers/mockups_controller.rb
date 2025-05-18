class MockupsController < ApplicationController
  def index
  end

  def show
    render template: "mockups/#{params[:id]}"
  rescue ActionView::MissingTemplate
    render plain: "Mockup not found", status: :not_found
  end

  def analyse_page
    url = params["url"]
    title = Extraction::TitleExtractor.call(url)
    table_of_contents = Extraction::TocExtractor.call(url)
    word_count = Extraction::WordCounter.call(url)
    puts "This is my title: #{title}"
    puts "This is my content: #{table_of_contents}"
    puts "This is my content: #{word_count}"
  end
  
end
