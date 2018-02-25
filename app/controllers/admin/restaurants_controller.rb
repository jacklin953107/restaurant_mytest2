class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
  def index
    @restaurants = Restaurant.all
  end
  def new
    @restaurant = Restaurant.new
  end
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "餐廳成功建立"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "餐廳建立失敗"
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @restaurant.update(restaurant_params)
      flashp[:notice] = "餐廳資料修改成功"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "餐廳資料修改失敗"
      render :edit
    end
  end
  def destroy
    if @restaurant.destroy
      flash[:notice] = "餐廳刪除成功"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "餐廳無法刪除"
    end
  end

  private
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow"
      redirect_to root_path
    end
  end
  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description)
  end
  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
