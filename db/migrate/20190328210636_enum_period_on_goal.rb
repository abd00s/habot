class EnumPeriodOnGoal < ActiveRecord::Migration[5.2]
  def up
    change_column :goals, :period, :integer, limit: 1
  end

  def down
    change_column :goals, :period, :string
  end
end
