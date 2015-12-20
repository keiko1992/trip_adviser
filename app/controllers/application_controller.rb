class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    if admin_signed_in?
      @current_ability ||= ::AbilityAdmin.new(current_admin)
    elsif user_signed_in?
      @current_ability ||= ::AbilityUser.new(current_user)
    else
      @current_ability ||= ::Ability.new(nil)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:last_name, :first_name, :city]
      devise_parameter_sanitizer.for(:account_update) << [:last_name, :first_name, :city]
    end
end
