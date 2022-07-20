class Article < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_one_attached :image
  has_rich_text :content
  has_many :favorites, dependent: :destroy

  has_many :bookmarks, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :title ,length: {minimum:2 ,maximum:50 }
  validates :title,format: { with: /\A(?!\@)/}
  validates :content, presence: true
  validates :subcontent, presence: true

  #今週
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  # 前週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

  def start_time
    created_at
  end

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

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
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
    old_tags = current_tags - savearticle_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = savearticle_tags - current_tags

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

  #通知
  #自分が通知する(いいね)
  # def create_notification_by(current_user)
  #   notification = current_user.active_notifications.new(
  #     article_id: id,
  #     visited_id: user_id,
  #     action: 'like'
  #   )
  #   notification.save if notification.valid?
  # end
  def  create_notification_by(current_user)
    favorite_exist = Notification.where('visiter_id = ? and visited_id = ? and article_id = ? and action = ? ', current_user.id, user.id, id, 'like') # いいねしているか検索
      if favorite_exist.blank? # いいねしていない場合に通知を作成
        notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id, # 通知相手に相手のidを指定
        action: 'like', # helperにて使用
        checked: false # defaultでfalse「未確認」を設定
        )
        # 自分の投稿に対するいいねは、通知済み
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save! if notification.valid?
      end
    end

  #自分が通知する(コメント)
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    #distinctで重複除く
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  #visited_idには通知を受け取るuser_id
  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  extend PageList
  #並び替え
  scope :sort_list, -> {
    {
      '並び替え' => '',
      '古い順' => 'updated_at asc',
      '新しい順' => 'updated_at desc'
    }
  }
  scope :sort_order, -> (order) { order(order) }
  scope :sort_articles, -> (sort_order, page) {
    sort_order(sort_order[:sort]).
    display_list(page)
  }
end
