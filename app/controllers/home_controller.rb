class HomeController < ApplicationController
  def index
    @content_pages = ContentPage.order(created_at: :desc).limit(10)
  end
end

# HomeController serves the main landing page of the application.

# The `index` action retrieves the 10 most recently created ContentPage records,
# ordering them by creation date in descending order to prioritize fresh content.
# These pages are then made available to the view via the `@content_pages` instance variable.

# Why this matters:
# By isolating this logic, it makes the codebase easier to maintain, allowing developers to add features or debug more effortlessly. 