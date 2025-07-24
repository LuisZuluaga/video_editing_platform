class AddVideoTypeToVideos < ActiveRecord::Migration[7.1]
  def change
    add_reference :videos, :video_type, null: false, foreign_key: true
  end
end
