class MenusController < ApplicationController

  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_restaurant
  before_action :set_sub_restaurant
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = @restaurant.menus.order(:name).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      if @menus.present?
        format.html
        format.json { render json: @menus }
      else
        format.html { redirect_to new_restaurant_menu_path(@restaurant), notice: 'You have no menus yet. Add a new menu.' }
        format.json { render json: { message: 'No menus found' }, status: :not_found }
      end
    end
  end

  def show
    if params[:search]
      @menu_categories = @menu.menu_categories.where("name ILIKE ?", "%#{params[:search]}%").order(:name).paginate(page: params[:page], per_page: 10 )
      @menu_items = @menu.menu_items.where("name ILIKE ?", "%#{params[:search]}%").order(:name).paginate(page: params[:page], per_page: 10 )
    else
      @menu_categories = @menu.menu_categories.order(:name).paginate(page: params[:page], per_page: 10 )
      @menu_items = @menu.menu_items.order(:name).paginate(page: params[:page], per_page: 10 )
    end
  end

  def new
    @menu = @sub_restaurant ? @sub_restaurant.menus.new : @restaurant.menus.new
  end

  def create
    @menu = @sub_restaurant ? @sub_restaurant.menus.new(menu_params) : @restaurant.menus.new(menu_params)

    respond_to do |format|
      if @menu.save
        redirect_path = request.referrer ? request.referrer : restaurant_menus_path(@restaurant)
        format.html { redirect_to redirect_path, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: [@restaurant, @menu] }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        redirect_path = request.referrer ? request.referrer : restaurant_menus_path(@restaurant)
        format.html { redirect_to redirect_path, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: [@restaurant, @menu] }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_menus_url(@restaurant), notice: 'Menu was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def set_sub_restaurant
      @sub_restaurant = @restaurant.sub_restaurants.friendly.find(params[:sub_restaurant_id]) if params[:sub_restaurant_id]
    end

    def set_menu
      @menu = @restaurant.menus.friendly.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:name, :description, :restaurant_id)
    end
end