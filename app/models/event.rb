class Event < ApplicationRecord
  validates :goal_period_id, :date, presence: true

  belongs_to :goal_period
end
