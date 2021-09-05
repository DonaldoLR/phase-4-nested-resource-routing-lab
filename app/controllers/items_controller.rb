class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_user_not_found

  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
    else
      items = Item.all
    end
    render json: items, include: :user, status: :ok
  end

  def show 
    item = Item.find(params[:id])
    render json: item, status: :ok
  end

  def create 
    user = User.find(params[:user_id])
    item = user.items.create(items_params)
    render json: item, status: :created
  end

  private 
  def items_params 
    params.permit(:name, :description, :price)
  end
  def render_user_not_found 
    render json: {error: 'User not Found'}, status: :not_found
  end
end
