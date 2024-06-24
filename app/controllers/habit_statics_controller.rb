class HabitStaticsController < ApplicationController

  def show
    @habit_static = HabitStatic.find(params[:id])
  end
end
