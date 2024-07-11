class Habit < ApplicationRecord
  FREQUENCIES = %w[daily weekly].freeze
  STATUSES = %w[active inactive].freeze
  CATEGORIES = {
    "Health" => "fas fa-heartbeat",
    "Creativity" => "fas fa-lightbulb",
    "Learning" => "fas fa-book",
    "Mindfulness" => "fas fa-spa",
    "Quit a bad habit" => "fas fa-ban",
    "Art" => "fas fa-paint-brush",
    "Sports" => "fas fa-basketball-ball",
    "Entertainment" => "fas fa-film",
    "Social" => "fas fa-users",
    "Finance" => "fas fa-dollar-sign",
    "Work" => "fas fa-briefcase",
    "Nutrition" => "fas fa-apple-alt",
    "Home" => "fas fa-home",
    "Outdoor" => "fas fa-tree"
  }.freeze

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

  # get user active habits count (habits that have future occurrences, includinbg today)
  def self.active_habits_count(user)
    user.habits.joins(:occurrences).where('date >= ? AND completion_status = ?', Date.today, 'pending').distinct.count
  end

  # check if habit ended
  def ended?
    end_date <= Date.today
  end


  private

  def create_occurrences
    start_date = self.start_date
    end_date = self.end_date

    if self.frequency == 'daily'
      (start_date...end_date).each do |date|
        Occurrence.create(date: date, habit: self)
      end
    elsif self.frequency == 'weekly'
      # days_of_week_array = days_of_week.map(&:to_s)
      (start_date...end_date).each do |date|
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

  def self.completed_today
    joins(:occurrences).where(occurrences: { date: Date.today, completion_status: 'completed' }).distinct.count
  end

  def self.total_today_for_user(user)
    joins(:occurrences).where(user: user, occurrences: { date: Date.today }).distinct.count
  end

  def self.percentage_completed_today_for_user(user)
    total_habits = total_today_for_user(user)
    completed_habits = completed_today

    return 0 if total_habits == 0

    (completed_habits.to_f / total_habits.to_f * 100).to_i
  end
end
