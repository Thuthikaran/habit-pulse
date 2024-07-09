class OccurrencesController < ApplicationController
  def complete
    # Find the occurrence by id in the params and update status to completed
    @occurrence = Occurrence.find(params[:id])
    @occurrence.update(completion_status: 'completed')
    # Find the habit_statistic by habit_id and update the completion count
    @occurrence.habit.habit_static.completed_occurrences += 1
    redirect_to habits_path, notice: 'Habit was successfully completed.'
  end
end
