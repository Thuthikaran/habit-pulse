class HabitsController < ApplicationController

  def index
    @habits = Habit.all
  end

  def new 
    @habits = Habit.new
  end
end
