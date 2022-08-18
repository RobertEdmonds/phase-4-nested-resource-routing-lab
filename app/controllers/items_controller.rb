class ItemsController < ApplicationController

  def index
    # user = User.find_by(id: params[:user_id])
    # if user == true
    #   items = user.items
    #   return render json: items, include: :user
    # elsif user == false
    #   return render json: {error: "Not found"}, status: :not_found
    # else
    #   items = Item.all
    #   return render json: items, include: :user
    # end
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user 
        items = user.items 
      else
        render json: {error: "Not found"}, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show 
    user = Item.find_by(id: params[:id])
    if user 
      item = Item.find(params[:id])
      render json: item, include: :user
    else
      render json: {error: 'Not Found'}, status: :not_found
    end
  end

  def create 
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
    else
      item = Item.create(item_params)
    end
    render json: item, status: :created
  end

private

  def item_params 
    params.permit(:name, :description, :price, :user_id)
  end


end
