class RemoveStatusFromVideos < ActiveRecord::Migration[7.1]
  def change
    remove_column :videos, :status, :integer
  end
end
