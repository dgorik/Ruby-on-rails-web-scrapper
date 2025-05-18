class HistoryPagesController < ApplicationController
  def show
    @content_page = ContentPage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Page not found"
  end
end