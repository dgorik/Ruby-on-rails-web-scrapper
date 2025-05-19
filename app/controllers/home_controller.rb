class HomeController < ApplicationController
  def index
    @content_pages = ContentPage.order(created_at: :desc).limit(10)
  end
end
