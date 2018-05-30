class ApplicationController < ActionController::Base
  before_action :authenticate_profile!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    keys = [:name, :surname, :middlename, :age]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end
end
