class OrdersController < ApplicationController
  before_action :set_order, only: [:index,:create ]
  before_action :authenticate_user!, only: [:index] 

  def index
    @order_buyer = OrderBuyer.new 
    if current_user.id  == @item.user_id || @item.order.present?
    redirect_to root_path
    end
  end



  def create
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid?
      pay_item
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

  
  
  private
# ここは確認が必要 エラーに繋がる可能性が大きい!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
  def order_params
    params.require(:order_buyer).permit(:post_code, :sender_id, :municipalities, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,   # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end


end
