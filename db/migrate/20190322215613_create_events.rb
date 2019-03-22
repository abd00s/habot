class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :goal_id
      t.date :date

      t.timestamps
    end
  end
end
