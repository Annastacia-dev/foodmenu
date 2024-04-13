class LayoutsController < ApplicationController
  before_action :authenticate_super_admin!, except: %i[index show]
  before_action :set_layout, only: %i[show edit update destroy]

  def index
    @layouts = Layout.all
  end

  def show
    if @restaurant
      @restaurant.update(layout_id: @layout.id)
      redirect_to restaurant_show_path(@restaurant)
    else
      restaurant = Restaurant.find_by(sample: true)
      restaurant.update(layout_id: @layout.id)
      redirect_to restaurant_show_path(restaurant)
    end
  end

  def new
    @layout = Layout.new
  end

  def edit; end

  def create
    @layout = Layout.new(layout_params)

    respond_to do |format|
      if @layout.save
        format.html { redirect_to layouts_path, notice: 'Layout was successfully created.' }
        format.json { render :show, status: :created, location: @layout }
      else
        format.html { render :new }
        format.json { render json: @layout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @layout.update(layout_params)
        format.html { redirect_to layouts_path, notice: 'Layout was successfully updated.' }
        format.json { render :show, status: :ok, location: @layout }
      else
        format.html { render :edit }
        format.json { render json: @layout.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @layout.destroy
    redirect_to layouts_url, notice: 'Layout was successfully destroyed.'
  end

  private

  def set_layout
    @layout = Layout.friendly.find(params[:id])
  end

  def layout_params
    params.require(:layout).permit(:name, :description, :image)
  end
end