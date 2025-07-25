class Video < ApplicationRecord

  belongs_to :project
  belongs_to :video_type

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :format, presence: true
end
