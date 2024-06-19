class HabitsController < ApplicationController

  def index
    @habits = Habit.all
  end
end
