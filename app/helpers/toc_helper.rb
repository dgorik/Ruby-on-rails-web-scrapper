module TocHelper
  def render_toc(toc_content)
    
    return 'No table of content to display' if toc_content.empty?# Renamed from html_content to toc_content

    toc_items = JSON.parse(toc_content, symbolize_names: true)

    # is symbolize_names necessary?

    return '' if toc_items.empty?

    # is there a reason why we are checking if toc is empty twice
    
    content_tag :nav, class: 'toc-container', role: 'navigation', 'aria-label': 'Table of Contents' do
      content_tag :ul, class: 'toc-list' do
        toc_items.map do |item|
          content_tag :li, class: "toc-item toc-depth-#{item[:depth]}" do
            link_to item[:title], item[:href], data: { turbolinks: 'false' }
          end
        end.join.html_safe
      end
    end
  end
end
