class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    
    self.per_page = 5
end
