class GoalPeriod < ApplicationRecord
  validates :goal_id, :start_date, presence: true
  validates :start_date, beginning_of_week: true

  belongs_to :goal
  has_many :events, dependent: :destroy

  delegate :frequency, to: :goal
end
