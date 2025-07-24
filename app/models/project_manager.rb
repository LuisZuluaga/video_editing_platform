class ProjectManager < ApplicationRecord
  has_many :projects
  has_many :notifications

  validates :name, presence: true
  validates :email, presence: true
end
