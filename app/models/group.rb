class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users,  dependent: :destroy
  has_many :users, through: :group_users,  dependent: :destroy, source: :user

  validates :name, presence: true, length: { in: 2..30 }
  validates :introduction, presence: true, length: { in: 2..100 }
  
#ActiveStrageの紐付け
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  #グループ作成者か確認する
  def is_owned_by?(user)
    owner.id == user.id
  end
  #そのユーザーはグループに存在しているか
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
end
