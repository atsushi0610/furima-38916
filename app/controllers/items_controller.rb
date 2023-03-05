class ItemsController < ApplicationController
  #before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!, except: :index

  def index
    #@items = Item.order("created_at DESC")
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
    params.require(:item).permit(:image,:title,:description,:category_id,:condition_id,:postage_id,:region_id,:duration_id,:price).merge(user_id: current_user.id)
  end

end
