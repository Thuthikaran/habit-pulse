class HabitsController < ApplicationController

  def index
    @habits = Habit.all
  end

  def new
    @habit = Habit.new
  end

  def create

    @habit = Habit.new(habit_params)
    @habit.user = current_user
    if @habit.save
      redirect_to habits_path, notice: 'Habit was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def today
    @habits = habit.where("DATE(created_at) = ?", Date.today)
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, days_of_week: [])
  end
end
