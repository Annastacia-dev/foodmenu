
class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  

  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name restaurant_id role])
  end
end
