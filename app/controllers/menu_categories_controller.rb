class MenuCategoriesController < ApplicationController

  before_action :set_restaurant
  before_action :set_sub_restaurant
  before_action :set_menu
  before_action :set_menu_category, only: %i[show edit update destroy]

  def index
    @menu_categories = @menu.menu_categories

    respond_to do |format|
      if @menu_categories.present?
        format.html
        format.json { render json: @menu_categories }
      else
        format.html { redirect_to new_restaurant_menu_menu_category_path(@restaurant, @menu
        ), notice: 'You have no menu categories yet. Add a new menu category.' }
        format.json { render json: { message: 'No menu categories found' }, status: :not_found }
      end
    end
  end

  def show
  end

  def new
    @menu_category = @menu.menu_categories.new
  end

  def create
    @menu_category = @menu.menu_categories.new(menu_category_params)

    respond_to do |format|
      if @menu_category.save
        format.html { redirect_to restaurant_menu_path(@restaurant, @menu, tab: 'categories'), notice: 'Menu category was successfully created.' }
        format.json { render :show, status: :created, location: [@restaurant, @menu, @menu_category] }
      else
        format.html { render :new }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @menu_category.update(menu_category_params)
        format.html { redirect_to [@restaurant, @menu, @menu_category], notice: 'Menu category was successfully updated.' }
        format.json { render :show, status: :ok, location: [@restaurant, @menu, @menu_category] }
      else
        format.html { render :edit }
        format.json { render json: @menu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_category.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_menu_menu_categories_url(@restaurant, @menu), notice: 'Menu category was successfully destroyed.' }
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
  end

  def set_sub_restaurant
    @sub_restaurant = @restaurant.sub_restaurants.friendly.find(params[:sub_restaurant_id]) if params[:sub_restaurant_id].present?
  end

  def set_menu
    @menu = @sub_restaurant ? @sub_restaurant.menus.friendly.find(params[:menu_id]) : @restaurant.menus.friendly.find(params[:menu_id])
  end

  def set_menu_category
    @menu_category = @menu.menu_categories.friendly.find(params[:id])
  end

  def menu_category_params
    params.require(:menu_category).permit(:name, :description)
  end
end