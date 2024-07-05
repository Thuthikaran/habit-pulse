# app/controllers/dashbord_controller.rb
class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @user = current_user
      @completed_habits_today = @user.completed_habits_today.count
      @due_habits_today = @user.habits_due_today.count
      @completion_percentage = @user.completion_percentage
    end
  end
  