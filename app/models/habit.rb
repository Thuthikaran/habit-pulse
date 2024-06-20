FREQUENCIES = %w[daily weekly].freeze
STATUSES = %w[active inactive].freeze
CATEGORIES = %w[Health Creativity Learning Mindfulness].freeze

class Habit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { scope: :user_id }
  # restrict priority to 1-3
  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :start_date, presence: true
  validates :frequency, inclusion: { in: FREQUENCIES }
  validates :status, inclusion: { in: STATUSES }
  validates :category, inclusion: { in: %w[Health Creativity Learning Mindfulness] }
  validates :days_of_week, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }


  has_many :occurrences, dependent: :destroy
end
