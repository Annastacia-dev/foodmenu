class RestaurantsController < ApplicationController

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to projects_path, notice: "Restaurant was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def index
    @restaurants = Restaurant.all
  end

  private

  def restaurant_params
    params
    .require(:restaurant)
    .permit(:name, :email, :phone, :restaurant_type)
  end

end
