class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      redirect_to habits_path
    else
      # Render the home page or redirect to another path as needed
      render :home
    end
  end

  def contact
  end

  def about
  end
end
