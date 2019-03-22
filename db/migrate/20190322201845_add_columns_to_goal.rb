class AddColumnsToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :user_id, :integer, after: :id
    add_column :goals, :frequency, :integer, after: :title
    add_column :goals, :period, :string, after: :frequency
  end
end
