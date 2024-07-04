class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :habits, dependent: :destroy
        has_many :habit_completions, through: :habits

        # app/models/user.r

  def habits_due_today
    habits.where(end_date: Date.today)
  end

  def completed_habits_today
    habit_completions.where(completed: true, completed_at: Date.today)
  end

  def completion_percentage
    due = habits_due_today.count
    return 0 if due.zero?
    completed = completed_habits_today.count
    (completed.to_f / due * 100).round(2)
  end
         def guest?
          guest
        end
end

