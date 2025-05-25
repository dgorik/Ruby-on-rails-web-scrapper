class HistoryPagesController < ApplicationController
  def show
    @content_page = ContentPage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Page not found"
  end
end

# This controller handles showing previously analyzed pages.
# It tries to find the page by its ID from the URL.
# If the page isn’t found, it redirects back to the home page and shows an error message using flash alerts.

# Why this matters:
# Keeping HistoryPagesController separate improves maintainability, making the app easier to scale and extend when working with displaying historical content.