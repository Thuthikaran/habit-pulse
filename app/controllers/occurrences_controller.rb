class OccurrencesController < ApplicationController
  def complete
    # Find the occurrence by id in the params and update status to completed
    @occurrence = Occurrence.find(params[:id])
    @occurrence.update(completion_status: 'completed')
    redirect_to habits_path, notice: 'Habit was successfully completed.'
  end
end
