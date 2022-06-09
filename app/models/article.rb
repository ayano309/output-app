class Article < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_one_attached :image
  has_rich_text :content
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :comments, dependent: :destroy

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

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

  #タグ
  def save_tags(savearticle_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - savebook_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = savebook_tags - current_tags
		
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
		
    # 新しいタグを保存
    new_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << article_tag
    end
  end

end
