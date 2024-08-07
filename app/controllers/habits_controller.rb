class HabitsController < ApplicationController

  before_action :set_habit, only: %i[edit update destroy end]

  def edit
  end

  def end
    # end the habit
    @habit.end_date = Date.today
    @habit.save
    #delete future occurrences of habit
    @habit.occurrences.where('date >= ? AND completion_status = ?', Date.today, 'pending').destroy_all
    redirect_to habits_path, notice: 'Habit was successfully ended.'
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
    # get habits that have occurrences for today and order by occurrence completion status descending
    @habits = current_user.habits.select { |habit| habit.today_occurrence.present? }
    @habits = @habits.sort_by { |habit| habit.occurrences.find_by(date: Date.today).completion_status }.reverse
  end

  def new
    @habit = Habit.new
  end

  def create

    @habit = Habit.new(habit_params)
    @habit.status = 'active'
    @habit.user = current_user
    @habit.days_of_week = habit_params[:days_of_week].split(',')
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
    params.require(:habit).permit(:name, :priority, :start_date, :end_date, :reminder, :frequency, :status, :category, :description, :days_of_week)
  end

  def set_habit
    @habit = Habit.find(params[:id])
  end

end
