class RestaurantsController < ApplicationController

  before_action :authenticate_user!, except: %i[show confirm confirm_email]
  before_action :find_restaurant, only: %i[show edit update destroy confirm confirm_email settings]
  before_action :set_category, only: %i[show]
  before_action :set_main_item, only: %i[show]

  def new
    @restaurant = Restaurant.new
  end

  def show
    @layout = @restaurant.layout
    if @layout
      render layout: "#{@layout.name}/index"
    else
      render layout: "default/index"
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
          send_confirmation_email(@restaurant)
         format.html { redirect_to confirm_restaurant_path(@restaurant) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
    end
  end

  def confirm
  end

  def confirm_email
    @restaurant.update(confirmed: true, confirmed_at: Time.zone.now, status: :active)
    redirect_to new_user_registration_path(restaurant: @restaurant.slug)
  end

  def index
    @restaurants = Restaurant.all
  end

  private

  def restaurant_params
    params
    .require(:restaurant)
    .permit(:name, :email, :phone, :restaurant_type, :logo)
  end

  def send_confirmation_email(restaurant)
    RestaurantMailer.with(restaurant: restaurant).confirmation_email.deliver_now
  end

  def find_restaurant
    @restaurant = Restaurant.friendly.find(params[:id])
  end

  def set_category
    @category = @restaurant.menu_categories.find_by(slug: params[:category]) || @restaurant.menu_categories.order(:name).first
  end

  def set_main_item
    @main_item = @category.menu_items.find_by(slug: params[:item]) || @category.menu_items.order(:name).reverse.first
  end
end
