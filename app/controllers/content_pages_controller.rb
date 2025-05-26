class ContentPagesController < ApplicationController
  def create
    result = PageAnalyzer.call(params[:url])

    if result[:error]
      flash[:alert] = result[:error]
      return redirect_to root_path
    end

    @page_analysis = ContentPage.create!(
      url: result[:url],
      title: result[:title],
      word_count: result[:word_count],
      top_10_words: result[:top_10_words],
      table_of_contents: result[:table_of_contents]
    )

    redirect_to content_page_path(@page_analysis[:id])
  end

  def show
    @content_page = ContentPage.find_by(id: params[:id])
    unless @content_page
      redirect_to root_path, alert: "No page analysis found"
    end
  end
end

# PageAnalyzer Service:
# - Checks if the URL is valid, gets the page’s HTML, cleans it up,
#   and pulls out important info like the title, table of contents,
#   word count, and top words.
# - If something goes wrong (like a bad URL), it returns an error message
#   that the controller shows using flash alerts.
# - Keeps all the heavy analysis work separate from the controllers.

# Why it matters:
# - Helps keep controllers simple and easy to read.
# - Makes it easier to test and fix the code.
# - Lets us improve or add features later without breaking things.
# - Shows helpful error messages to users when needed.
