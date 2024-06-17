class Habit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
 # restrict priority to 1-3
  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :start_date, presence: true
  validates :frequency, inclusion: { in: %w[daily weekly] }
  validates :status, inclusion: { in: %w[active inactive] }
end
