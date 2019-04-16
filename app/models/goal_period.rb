class GoalPeriod < ApplicationRecord
  validates :goal_id, :start_date, presence: true

  belongs_to :goal
  has_many :events, dependent: :destroy
end
