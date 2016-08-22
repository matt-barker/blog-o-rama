json.extract! article, :id, :title, :body, :image_url, :has_image, :date_posted, :author, :created_at, :updated_at
json.url article_url(article, format: :json)