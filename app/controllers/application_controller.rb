class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  include Devise::Controllers::Helpers

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo])
  end

  def not_found
    render status: :not_found, template: 'errors/404'
  end

  def bad_request
    render status: :bad_request, template: 'errors/400'
  end

  def internal_server_error
    render status: :internal_server_error, template: 'errors/500'
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActionController::BadRequest, with: :bad_request
  rescue_from StandardError, with: :internal_server_error
end
