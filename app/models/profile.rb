class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  enum gender: { male: 0, female: 1, other: 2 }
end
