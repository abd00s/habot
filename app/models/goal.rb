class Goal < ApplicationRecord
  enum period: %i[week month]

  validates :user_id, :title, :frequency, :period, presence: true

  has_many :goal_periods, dependent: :destroy
  has_many :events, through: :goal_periods
  belongs_to :user
end
