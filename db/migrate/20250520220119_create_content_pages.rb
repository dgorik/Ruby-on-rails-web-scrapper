class CreateContentPages < ActiveRecord::Migration[8.0]
  def change
    create_table :content_pages do |t|
      t.string :title
      t.string :url
      t.json :table_of_contents
      t.string :word_count
      t.json :top_10_words

      t.timestamps
    end
  end
end
