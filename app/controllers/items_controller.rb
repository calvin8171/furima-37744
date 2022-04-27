class ItemsController < ApplicationController
  def index
  end

  def new
    @items = Item.order("created_at DESC")
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :good_name, :good_description, :category_id, :good_condition_id, :shipping_fee_payer_id, :shipping_area_id, :day_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
