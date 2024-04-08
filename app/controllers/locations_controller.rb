class LocationsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :find_location, only: %i[edit update destroy]
  before_action :find_restaurant, only: %i[edit update destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    redirect_path = params[:location][:redirect_path]

    if @location.save
      redirect_to redirect_path, notice: 'Location was successfully added.'
    else
      errors = @location.errors.full_messages.join(', ')
      redirect_to redirect_path, alert: "Location was not added. #{errors}"
    end
  end

  def edit
  end

  def update
    redirect_path = params[:location][:redirect_path]
    
    if @location.update(location_params)
      redirect_to redirect_path, notice: 'Location was successfully updated.'
    else
      errors = @location.errors.full_messages.join(', ')
      redirect_to redirect_path, alert: "Location was not updated. #{errors}"
    end
  end

  def destroy
    @location.destroy
    redirect_to request.referer, notice: 'Location was successfully deleted.'
  end


  private

  def find_location
    @location = Location.friendly.find(params[:id])
  end

  def find_restaurant
    @restaurant = @location.locatable
  end

  def location_params
    params.require(:location).permit(:area, :building_name, :city, :country, :county, :extra_directions, :floor_number, :nearest_landmark, :postal_code, :state, :status, :locatable_id, :locatable_type)
  end
end