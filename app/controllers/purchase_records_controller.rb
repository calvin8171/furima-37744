class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_record_shipping_info = PurchaseRecordShippingInfo.new
    if current_user == @item.user
      redirect_to root_path
    end
    if current_user != @item.user
      if @item.purchase_record.present?
        redirect_to root_path
      end
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_record_shipping_info = PurchaseRecordShippingInfo.new(purchase_record_shipping_info_params)
    if @purchase_record_shipping_info.valid?
      pay_item
      @purchase_record_shipping_info.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_record_shipping_info_params
    params.require(:purchase_record_shipping_info).permit(:postal_code, :prefecture_id, :municipalities, :banchi, :tatemono_name, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_shipping_info_params[:token], 
      currency: 'jpy'                 
    )
  end
end

  