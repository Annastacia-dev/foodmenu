class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @restaurant = Restaurant.friendly.find(params[:restaurant])
    super
  end

  def create
    @restaurant = Restaurant.friendly.find(params[:user][:restaurant_id])
    super
  end
end