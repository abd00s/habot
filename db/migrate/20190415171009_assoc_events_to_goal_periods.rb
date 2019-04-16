class AssocEventsToGoalPeriods < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :goal_id, :goal_period_id
  end
end
