class MenusController < ApplicationController

  before_action :set_restaurant
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = @restaurant.menus

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
  end

  def new
    session[:menu_params] ||= {}
    @menu = Menu.new
    @menu.current_step = session[:menu_step]
  end

  def create
    session[:menu_params].deep_merge!(menu_params) if menu_params
    @menu = Menu.new(session[:menu_params])
    @menu.current_step = session[:menu_step]
    if params[:back_button]
      @menu.previous_step
    else
      @menu.next_step if @menu.valid?
    end
    session[:menu_step] = @menu.current_step

    if @menu.save
      if @menu.last_step?
        session[:menu_step] = session[:menu_params] = nil
        redirect_to [@restaurant, @menu], notice: 'Menu was successfully created.'
      else
        redirect_to new_restaurant_menu_path(@restaurant)
      end
    else
      redirect_to new_restaurant_menu_path(@restaurant)
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to [@restaurant, @menu], notice: 'Menu was successfully updated.' }
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
      format.html { redirect_to restaurant_menus_url(@restaurant), notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:restaurant_id])
    end

    def set_menu
      @menu = @restaurant.menus.find(params[:id])
    end
end