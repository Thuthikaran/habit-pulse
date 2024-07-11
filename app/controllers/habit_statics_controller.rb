class HabitStaticsController < ApplicationController
  before_action :update_habit_statics, only: [:show]

  def show
    @habit_static = HabitStatic.find(params[:id])
    @habit = @habit_static.habit
  end

  private

  def update_habit_statics
    stats = HabitStatic.find(params[:id])
    stats.completed_occurrences = Occurrence.where(habit_id: stats.habit, completion_status: 'completed').count
    stats.missed_occurrences = Occurrence.where(habit_id: stats.habit, completion_status: 'pending').select { |missed| missed.date < Date.today}.count
    stats.total_occurrences = Occurrence.where(habit_id: stats.habit).select { |occurrence| occurrence.date <= Date.today}.count
    stats.save!
  end
end
