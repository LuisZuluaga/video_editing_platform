class Notification < ApplicationRecord
  belongs_to :project
  belongs_to :project_manager

  validates :message, presence: true
  validates :delivered_at, presence: true
end
