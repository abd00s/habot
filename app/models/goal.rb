class Goal < ApplicationRecord
  validates :user_id, :title, :frequency, :period, presence: true

  has_many :events, dependent: :destroy
  belongs_to :user
end
