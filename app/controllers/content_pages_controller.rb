class ContentPagesController < ApplicationController

  def create
    url = params[:url]
    result = PageAnalyzer.call(url)
    
    @page_analysis = ContentPage.create!(
      url: url,
      title: result[:title],
      word_count: result[:word_count],
      top_10_words: result[:top_10_words],
      table_of_contents: result[:table_of_contents]
    )

    redirect_to content_page_path(@page_analysis)
    
  end

  def show
    # Here, fetch the last created PageAnalysis (or any logic you want)
    @content_page = ContentPage.find_by(id: params[:id])
    unless @content_page
      redirect_to "/", alert: "No page analysis found"
    end
  end
end

# You analyze each page once and store only the results (title, word count, etc.) instead of full HTML. This approach is better because it’s faster, uses less storage, reduces server load, and keeps the code simpler—making your app more efficient and easier to maintain.
