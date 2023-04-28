class OrdersController < ApplicationController

  def index
    
  end

  def new
    @order_buyer = OrderBuyer.new
  end


  def create
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid?
      @order_buyer.save
      redirect_to root_path
    else
      render :new
    end
  end

  
  
  private
# ここは確認が必要 エラーに繋がる可能性が大きい!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
  def order_params
    params.require(:order_adress).permit(:post_code, :sender_id, :municipalities, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item_id )
  end


end
