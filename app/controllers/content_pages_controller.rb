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
