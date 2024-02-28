class HomeController < ApplicationController
  def index
    @restaurant = current_user&.restaurant
  end
end
