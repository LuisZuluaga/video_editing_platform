class Video < ApplicationRecord
  enum status: { queued: "queued", editing: "editing", done: "done" }

  belongs_to :project

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :format, presence: true
  validates :notes, presence: true
end
