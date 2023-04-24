class ItemsController < ApplicationController

 before_action :move_to_session, only: [:new]  

def index
  # @item = Item.all  
end



def new
  @item = Item.new
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
  params.require(:item).permit(:item_name, :explanation, :category_id, :status_id, :shipping_charge_id, :sender_id, :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
end

def move_to_session
  unless user_signed_in? 
   redirect_to new_user_session_path
  end
 end


end
