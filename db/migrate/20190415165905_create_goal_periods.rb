class CreateGoalPeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :goal_periods do |t|
      t.belongs_to :goal, foreign_key: true
      t.datetime :start_date
      t.boolean :goal_met, default: false

      t.timestamps
    end
  end
end
