class VideoType < ApplicationRecord
  has_many :videos

  validates :name, presence: true
  validates :format, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
