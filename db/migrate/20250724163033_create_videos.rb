class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.decimal :price
      t.string :format
      t.text :notes
      t.string :status
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
