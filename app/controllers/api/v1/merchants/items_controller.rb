class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    items = MerchantItemsFacade.get_merchant_items(merchant)
    
    render json: ItemSerializer.new(items)
  end
end
