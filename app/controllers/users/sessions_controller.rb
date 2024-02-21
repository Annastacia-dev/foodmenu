class Users::SessionsController < Devise::SessionsController

  def new
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    super
  end
end