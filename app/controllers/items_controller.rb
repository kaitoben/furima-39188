class ItemsController < ApplicationController
 before_action :set_item, only: [:edit,:update, :show]
 before_action :move_to_session, only: [:new, :edit]  
 before_action :move_to_index, only: [:edit, :destroy]

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

end


def update
  if @item.update(item_params)
    redirect_to item_path
  else
    render :edit
  end
end




def show

end

def destroy
  item = Item.find(params[:id])
  item.destroy   
  redirect_to root_path
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
  unless  current_user.id == @item.user.id
    redirect_to action: :index
  end
end

def set_item
  @item = Item.find(params[:id])
end



end
