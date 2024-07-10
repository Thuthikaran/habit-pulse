class Habit < ApplicationRecord
  FREQUENCIES = %w[daily weekly].freeze
  STATUSES = %w[active inactive].freeze
  CATEGORIES = ["Health", "Creativity", "Learning", "Mindfulness", "Quit a bad habit", "Art",
                "Sports", "Entertainment", "Social", "Finance", "Work", "Nutrition", "Home", "Outdoor"].freeze
  DAYS_OF_WEEK = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze

  belongs_to :user
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { scope: :user_id }
  # restrict priority to 1-3
  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :end_date, presence: true
  validates :frequency, presence: true
  # require days_of_week if frequency is weekly
  validates :days_of_week, presence: true, if: :weekly?
  validates :status, presence: true
  validates :category, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :frequency, inclusion: { in: FREQUENCIES }
  validates :status, inclusion: { in: STATUSES }
  validates :category, inclusion: { in: CATEGORIES }
  # validates :days_of_week, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }


  has_many :occurrences, dependent: :destroy
  has_one :habit_static, dependent: :destroy
  belongs_to :user
  has_many :habit_completions, dependent: :destroy

  # callback to create a habit_statics record when a habit is created
  after_create :create_habit_statics

  # callback to create occurrences for a habit based on frequency, between start_date and end_date, if end_date is nil then it is set to 1 year from start_date
  after_create :create_occurrences

  #callback to delete and recreate future occurrences starting from today when a habit is updated, if frequency changed
  after_update :delete_and_recreate_occurrences

  # get today's occurrence
  def today_occurrence
    occurrences.find_by(date: Date.today)
  end

  # Check if habit is weekly
  def weekly?
    frequency == 'weekly'
  end

  private

  def create_occurrences
    start_date = Date.today

    if self.frequency == 'daily'
      (start_date...(start_date + 1.months)).each do |date|
        Occurrence.create(date: date, habit: self)
      end
    elsif self.frequency == 'weekly'
      # days_of_week_array = days_of_week.map(&:to_s)
      (start_date...(start_date + 6.months)).each do |date|
        if self.days_of_week.include?(date.strftime('%A'))
          Occurrence.create(date: date, habit: self)
        end
      end
    end
  end

  def delete_and_recreate_occurrences

    if self.saved_change_to_frequency || self.saved_change_to_days_of_week

      self.occurrences.where('date >= ? AND completion_status = ?', Date.today, 'pending').destroy_all
      create_occurrences
    end
  end

  def create_habit_statics
    HabitStatic.create(habit_id: self.id)
  end

end

# def create_occurrences(habit)
#   # Calculate start date one week ago
#   start_date = 1.week.ago.to_date

#   rand(1..5).times do
#     occurrence_date = Faker::Date.between(from: start_date, to: Date.today)
#     occurrence = Occurrence.new(date: occurrence_date, habit: habit)
#     occurrence.completion_status = Occurrence::COMPLETION_STATUSES.sample
#     occurrence.save!
#   end
# end
