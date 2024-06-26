class HabitsController < ApplicationController

  def index
    # get habits that have occurrences for today
    @habits = current_user.habits.select { |habit| habit.today_occurrence.present? }


  end

  def new
    @habit = Habit.new
  end

  def create

    @habit = Habit.new(habit_params)
    @habit.status = 'active'
    @habit.frequency = 'daily'
    @habit.start_date = Date.today
    @habit.user = current_user
    if @habit.save
      redirect_to habits_path, notice: 'Habit was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, days_of_week: [])
  end
end
