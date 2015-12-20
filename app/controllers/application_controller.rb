class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
