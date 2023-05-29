class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  add_flash_types :success, :danger, :info, :warning
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
