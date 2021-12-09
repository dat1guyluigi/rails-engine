class Api::V1::ItemsController < ApplicationController
  before_action :item, only: [:show, :update, :destroy]

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(item)
    end
  end

  def update
    if @item.update(item_params)
      ItemSerializer.new(@item)
    end
  end

  def destroy
    ItemSerializer.new(@item.destroy)
  end

  private

  def item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
