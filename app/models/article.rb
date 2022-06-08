class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true
  validates :title ,length: {minimum:2 ,maximum:50 }
  validates :title,format: { with: /\A(?!\@)/}

  validates :content, presence: true
  validates :subcontent, presence: true
end
