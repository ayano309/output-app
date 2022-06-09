class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_rich_text :content
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

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



  #ユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索
  def self.search_for(content, method)
    if method == 'partial'
      Article.where('title LIKE ?', '%'+content+'%')
    end
  end

end
