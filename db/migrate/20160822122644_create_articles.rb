class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :image_url
      t.boolean :has_image
      t.date :date_posted
      t.string :author

      t.timestamps
    end
  end
end
