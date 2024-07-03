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
    @habits = current_user.habit.where("DATE(created_at) = ?", Date.today)
  end

  def filter_by_date
    selected_date = params[:date]
    @habits = current_user.habits.where('DATE(occurrence_date) = ?', selected_date)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @habits }
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, days_of_week: [])
  end
end
