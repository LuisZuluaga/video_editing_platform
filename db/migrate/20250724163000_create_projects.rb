class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :status
      t.text :raw_footage_url
      t.decimal :total_price
      t.references :client, null: false, foreign_key: true
      t.references :project_manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
