class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_errror
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items 
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show 
    # user = Item.find_by(id: params[:id]) 
    item = Item.find(params[:id])
    render json: item
  end

  def create 
    # if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
    # else
    #   item = Item.create(item_params)
    # end
    render json: item, status: :created
  end

private

  def item_params 
    params.permit(:name, :description, :price, :user_id)
  end
  
  def render_errror(exception) 
    render json: {error: "#{exception.model} Not found" }, status: :not_found
  end

end
