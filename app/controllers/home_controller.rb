class HomeController < ApplicationController

  def index
    @restaurant = current_user&.restaurant
  end

  def restaurant
    @restaurant = Restaurant.find_by(slug: params[:restaurant_id])
    @layout = @restaurant&.layout
    if @restaurant
      if @layout
        render layout: "#{@layout.name}/index"
      else
        render layout: "default/index"
      end
    end
  end
end
