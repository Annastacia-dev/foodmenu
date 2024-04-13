class MenuItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_restaurant
  before_action :set_sub_restaurant
  before_action :set_menu
  before_action :set_menu_category
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  def index
    @menu_items = @menu_category.menu_items.order(:name).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      if @menu_items.present?
        format.html
        format.json { render json: @menu_items }
      else
        format.html { redirect_to restaurant_menu_menu_category_menu_items_path(@restaurant, @menu, @menu_category), notice: 'You have no menu items yet. Add a new menu item.' }
        format.json { render json: { message: 'No menu items found' }, status: :not_found }
      end
    end
  end

  def show
  end

  def new
    session[:menu_item_params] ||= {}
    @menu_item = @menu_category.menu_items.new
    @menu_item.current_step = session[:menu_item_step]
  end

  def create
    session[:menu_item_params].deep_merge!(params[:menu_item]) if params[:menu_item]
    @menu_item = @menu_category.menu_items.new(session[:menu_item_params])
    @menu_item.current_step = session[:menu_item_step]

    if params[:back_button]
      @menu_item.previous_step
    else
      @menu_item.next_step if @menu_item.valid?
    end

    session[:menu_item_step] = @menu_item.current_step

    respond_to do |format|
      if @menu_item.save
        if @menu_item.current_step == @menu_item.steps.last
          session[:menu_item_step] = session[:menu_item_params] = nil
          redirect_path = restaurant_menu_path(@restaurant, @menu, tab: 'items')
          format.html { redirect_to redirect_path, notice: 'Menu item was successfully created.' }
          format.json { render :show, status: :created, location: [@restaurant, @menu, @menu_category, @menu_item] }
        end
      else
        errors= @menu_item.errors.full_messages.join(', ')
        format.html { render :new }
        format.html { redirect_to redirect_path, alert: errors }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        redirect_path = restaurant_menu_path(@restaurant, @menu, @menu_category, tab: 'items')
        format.html { redirect_to redirect_path, notice: 'Menu item was successfully updated.' }
        format.json { render :show, status: :ok, location: [@restaurant, @menu, @menu_category, @menu_item] }
      else
        format.html { render :edit }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_menu_menu_category_menu_items_path(@restaurant, @menu, @menu_category), notice: 'Menu item was successfully deleted.' }
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
    @menu = @sub_restaurant ? @sub_restaurant.menus.friendly.find(params[:menu_id]) : @restaurant.menus.friendly.find(params[:menu_id])
  end

  def set_menu_category
    @menu_category = @menu&.menu_categories&.friendly.find_by(id: params[:menu_category_id]) || MenuCategory.friendly.find_by(slug: params[:menu_category_id])
  end

  def set_menu_item
    @menu_item = @menu_category&.menu_items&.friendly.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(
      :name, :description, :price, :vegan, :gluten_free, :contains_nuts, :lactose_free, :halal, :alcoholic, :calories_info, :images, :videos
    )
  end

end
