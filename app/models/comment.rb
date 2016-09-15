class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  
   self.per_page = 5
  
  validates :body, presence: true
  validates :user, presence: true
  validates :article, presence: true
end
