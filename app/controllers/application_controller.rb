
class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :set_restaurant

  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name restaurant_id role])
  end

  def authenticate_super_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.super_admin?
  end

  def set_restaurant
    @restaurant = current_user.restaurant if current_user
  end
end
