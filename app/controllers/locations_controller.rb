class LocationsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  private

  def find_location
    @location = Location.find(params[:id])
  end
end