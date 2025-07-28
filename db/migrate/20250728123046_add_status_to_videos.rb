class AddStatusToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :status, :string
  end
end
