class MockupsController < ApplicationController
  def index
  end

  def show
    render template: "mockups/#{params[:id]}"
  rescue ActionView::MissingTemplate
    render plain: "Mockup not found", status: :not_found
  end

  def create
    Rails.logger.info "Form submitted with params: #{params.inspect}"
    render plain: "Form submitted successfully"
  end
  
end
