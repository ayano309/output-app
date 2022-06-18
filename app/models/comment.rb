class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  
  validates :comment, presence: true, length: { maximum: 100 }
end
