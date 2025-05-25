module TocHelper
  def render_toc(toc_content)
    return 'No table of content to display' if toc_content.empty?

    toc_items = JSON.parse(toc_content, symbolize_names: true)

    return '' if toc_items.empty?

    content_tag :nav, class: 'toc-container', role: 'navigation', 'aria-label': 'Table of Contents' do
      content_tag :ul, class: 'toc-list' do
        toc_items.map do |item|
          content_tag :li, item[:title], class: "toc-item toc-depth-#{item[:depth]}" 
        end.join.html_safe
      end
    end
  end
end

# This helper method renders a Table of Contents (TOC) from a JSON string of TOC items.

# It parses the JSON string into an array of TOC entries, each with a title and nesting depth.
# If the input content is empty or contains no items, it returns 'No table of content to display'
# Otherwise, it builds a nested HTML structure showing the TOC structure.

# How it works:
# - Checks if the input JSON string is empty and returns a message if so.
# - Parses the JSON into an array of TOC item hashes with symbolized keys.
# - Returns an empty string if there are no TOC items after parsing.
# - Generates a <nav> element with appropriate ARIA roles and labels for accessibility.
# - Creates a <ul> list inside the nav, with each TOC item rendered as an <li>.
# - Applies CSS classes that include the nesting depth to each <li> for styling purposes.

# Why this matters:
# Isolating TOC rendering in a helper keeps view templates clean and makes the logic reusable.

# In production, this logic could be extended to:
# - Allow custom styling or templates for TOC items.
# - Add interactivity (collapsible sections).
