class CreateVideoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :video_types do |t|
      t.string :name
      t.string :format
      t.decimal :price

      t.timestamps
    end
  end
end
