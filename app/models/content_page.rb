class ContentPage < ApplicationRecord
#     validates :url, presence: true
#     validates :title, presence: true
#     validates :table_of_contents, presence: true
#     validates :word_count, presence: true
#     validates :top_10_words, presence: true
end


# Uncomment the following validations to enforce presence of all fields.
  #
  # This is useful in production if you want to avoid analyzing pages with missing or blank data.
  # Activating these validations will prevent pages with blank URLs, titles, table_of_contents,
  # word_count, or top_10_words from being saved to the database.