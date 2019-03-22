class Event < ApplicationRecord
  validates :goal_id, :date, presence: true

  belongs_to :goal
end
