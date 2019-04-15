class Goal < ApplicationRecord
  enum period: %i[week month]

  validates :user_id, :title, :frequency, :period, presence: true

  has_many :goal_periods, dependent: :destroy
  belongs_to :user
end
