class Event < ApplicationRecord
  validates :goal_period_id, :date, presence: true
  validates :date, uniqueness: { scope: :goal_period_id }

  belongs_to :goal_period
end
