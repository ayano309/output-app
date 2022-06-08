class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  enum gender: { male: 0, female: 1, other: 2 }

  def get_profile_image(width, height)
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      avatar.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    avatar.variant(resize_to_limit: [width, height]).processed
  end
  

end
