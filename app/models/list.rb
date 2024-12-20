class List < ApplicationRecord
  has_one_attached :photo
  has_many :bookmarks
  has_many :movies, through: :bookmarks, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  # List should destroy child saved movies when destroying self
end
