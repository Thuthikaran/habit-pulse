class HabitsController < ApplicationController

    before_action :set_habit, only: [:edit, :update, :destroy]

    def edit
    end

    def update

      if @habit.update(habit_params)
        redirect_to habits_path, notice: 'Habit was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @habit.destroy
      redirect_to habits_path, notice: 'Habit was successfully destroyed.'
    end

  def index
    # get habits that have occurrences for today
    @habits = current_user.habits.select { |habit| habit.today_occurrence.present? }

  end

  def new
    @habit = Habit.new
  end

  def complete
    @habit = Habit.find(params[:id])
    @habit.occurrences.find_by(date: Date.today).update(completion_status: 'completed')
    redirect_to habits_path, notice: 'Habit was successfully completed.'
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

  def today
    @habits = current_user.habits.where("DATE(created_at) = ?", Date.today)
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, days_of_week: [])
  end

  def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, days_of_week: [])
  end

  def set_habit
    @habit = Habit.find(params[:id])
  end


end
