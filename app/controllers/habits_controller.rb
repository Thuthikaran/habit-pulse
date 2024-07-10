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
    # renamed this to today_occurrences for clarification!
    @habits = current_user.habits.select { |habit| habit.today_occurrence.present? }
  end

  def new
    @habit = Habit.new
  end

  def create

    @habit = Habit.new(habit_params)
    @habit.status = 'active'
    @habit.start_date = Date.today
    @habit.user = current_user
    @habit.priority = 1
    if @habit.save
      redirect_to habits_path, notice: 'Habit was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def today
    @habits = current_user.habits.where("DATE(created_at) = ?", Date.today)
  end

  def filter_by_date
    selected_date = params[:date]

    # get habits that have occurrences for the selected date
    @habits = current_user.habits.select { |habit| habit.occurrences.find_by(date: selected_date).present? }

    #@habits = current_user.habits.where('DATE(occurrence_date) = ?', selected_date)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @habits }
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :details, days: [])
  end

  private

 def habit_params
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, :description, days_of_week: [])
  end
  def set_habit
    @habit = Habit.find(params[:id])
  end

end
