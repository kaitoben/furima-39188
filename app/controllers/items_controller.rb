class ItemsController < ApplicationController

 before_action :move_to_session, only: [:new, :edit]  
 before_action :move_to_index, only: [:edit]

def index
  @items = Item.all.order("created_at DESC")
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


def edit
  @item = Item.find(params[:id])
end


def update
  @item = Item.find(params[:id])
  
  if @item.update(item_params)
    redirect_to item_path
  else
    render :edit
  end
end




def show
  @item = Item.find(params[:id])
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



def move_to_index
  @item = Item.find(params[:id])
  unless  current_user.id == @item.user.id
    redirect_to action: :index
  end
end



end
