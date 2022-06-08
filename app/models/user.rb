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
  #profileあれば更新、なければ作成
  def prepare_profile
    profile || build_profile
  end
end
