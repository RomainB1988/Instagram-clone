class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :likes, numericality: { greater_than_or_equal_to: 0 }
end
