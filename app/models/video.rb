class Video < ApplicationRecord
  enum status: { queued: "queued", editing: "editing", done: "done" }
  
  belongs_to :project
end
