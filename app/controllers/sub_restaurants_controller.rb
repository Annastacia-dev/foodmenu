class SubRestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant
  before_action :set_sub_restaurant, only: [:show, :edit, :update, :destroy, :new_location]

  def index
    @sub_restaurants = @restaurant.sub_restaurants.active

    respond_to do |format|
      if @sub_restaurants.present?
        format.html
        format.json { render json: @sub_restaurants }
      else
        format.html { redirect_to new_restaurant_sub_restaurant_path(@restaurant), notice: 'You have no restaurants yet. Add a new restaurant.' }
        format.json { render json: { error: 'No sub restaurants found' }, status: :not_found }
      end
    end
  end

  def show
  end

  def new
    @sub_restaurant = @restaurant.sub_restaurants.new
  end

  def edit
  end

  def create
    @sub_restaurant = @restaurant.sub_restaurants.new(sub_restaurant_params)

    respond_to do |format|
      if @sub_restaurant.save
        format.html { redirect_to new_location_restaurant_sub_restaurant_path(@restaurant, @sub_restaurant), notice: 'Sub restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @sub_restaurant }
      else
        format.html { render :new }
        format.json { render json: @sub_restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sub_restaurant.update(sub_restaurant_params)
        format.html { redirect_to restaurant_sub_restaurants_path(@restaurant), notice: 'Sub restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_restaurant }
      else
        format.html { render :edit }
        format.json { render json: @sub_restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sub_restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_sub_restaurants_url(@restaurant), notice: 'Sub restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_location
    @location = Location.new
  end

  private

    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def set_sub_restaurant
      @sub_restaurant = @restaurant.sub_restaurants.friendly.find(params[:id])
    end

    def sub_restaurant_params
      params.require(:sub_restaurant).permit(:name, :description, :phone_number, :email, :logo, :layout_id)
    end
end