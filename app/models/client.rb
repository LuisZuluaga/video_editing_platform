class Client < ApplicationRecord
  has_many :projects
  
  validates :name, presence: true
  validates :email, presence: true
end
