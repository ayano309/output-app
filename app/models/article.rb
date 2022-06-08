class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_rich_text :content
  validates :title, presence: true
  validates :title ,length: {minimum:2 ,maximum:50 }
  validates :title,format: { with: /\A(?!\@)/}
  validates :content, presence: true
  validates :subcontent, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
