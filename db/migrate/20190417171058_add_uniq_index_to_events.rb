class AddUniqIndexToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, %i[goal_period_id date], unique: true
  end
end
