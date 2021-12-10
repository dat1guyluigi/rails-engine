class MerchantItemsFacade
  def self.get_merchant_items(merchant)
    Merchant.get_items(merchant)
  end
end
