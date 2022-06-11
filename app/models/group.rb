class Group < ApplicationRecord
  has_many :group_users,  dependent: :destroy
  has_many :users, through: :group_users,  dependent: :destroy, source: :user

  validates :name, presence: true
  validates :introduction, presence: true
#ActiveStrageの紐付け
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
