class LayoutsController < ApplicationController
  before_action :authenticate_super_admin!
  before_action :set_layout, only: %i[show edit update destroy]

  def index
    @layouts = Layout.all
  end

  def show; end

  def new
    @layout = Layout.new
  end

  def edit; end

  def create
    @layout = Layout.new(layout_params)

    if @layout.save
      redirect_to @layout, notice: 'Layout was successfully created.'
    else
      render :new
    end
  end

  def update
    if @layout.update(layout_params)
      redirect_to @layout, notice: 'Layout was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @layout.destroy
    redirect_to layouts_url, notice: 'Layout was successfully destroyed.'
  end

  private

  def set_layout
    @layout = Layout.find(params[:id])
  end

  def layout_params
    params.require(:layout).permit(:name, :description, :image)
  end
end