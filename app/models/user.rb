class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  has_one :profile, dependent: :destroy
  has_many :articles,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy

  has_many :group_users,  dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  #フォローの関係(２行目は一覧画面で使う)自分がフォローする
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  #フォロワーの関係(２行目は一覧画面で使う)自分がフォローされる
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  #自分が作った通知(active_notifications)
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  #自分宛の通知(passive_notifications)
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy


  # フォローしたときの処理
  def follow!(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォローを外すときの処理
  def unfollow!(user)
    relation = following_relationships.find_by!(following_id: user.id)
    relation.destroy!
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
    #following_relationships.exists?(following_id: user.id)
  end

  #profileあれば更新、なければ作成
  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'male.svg'
    end
  end

  #フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  #ゲストログイン
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
