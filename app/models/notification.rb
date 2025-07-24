class Notification < ApplicationRecord
  belongs_to :project
  belongs_to :project_manager
end
