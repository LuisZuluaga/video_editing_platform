class Project < ApplicationRecord
  enum status: { pending: "pending", in_progress: "in_progress", completed: "completed" }

  belongs_to :client
  belongs_to :project_manager
  has_many :videos
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :raw_footage_url, presence: true
end
