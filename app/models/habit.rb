class Habit < ApplicationRecord
  FREQUENCIES = %w[daily weekly].freeze
  STATUSES = %w[active inactive].freeze
  CATEGORIES = %w[Health Creativity Learning Mindfulness].freeze
  DAYS_OF_WEEK = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze

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
  has_one :habit_static, dependent: :destroy

  # callback to create a habit_statics record when a habit is created
  after_create :create_habit_statics

  # callback to create occurrences for a habit based on frequency, between start_date and end_date, if end_date is nil then it is set to 1 year from start_date
  after_create :create_occurrences

  # get today's occurrence
  def today_occurrence
    occurrences.find_by(date: Date.today)
  end

  private

  def create_occurrences
    end_date = self.end_date || self.start_date + 1.year
    if self.frequency == 'daily'
      (self.start_date..end_date).each do |date|
        self.occurrences.create(date: date)
      end
    elsif self.frequency == 'weekly'
      (self.start_date..end_date).each do |date|
        if self.days_of_week.include?(date.strftime('%A'))
          self.occurrences.create(date: date)
        end
      end
    end
  end

  def create_habit_statics
    HabitStatic.create(habit_id: self.id)
  end

end
