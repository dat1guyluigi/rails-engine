require 'rails_helper'

RSpec.describe 'Item merchant' do
  describe 'happy path' do
    it 'gets the merchant info of that item' do
      merchant = create(:merchant, id: 1)
      item = create(:item, merchant: merchant, id: 1)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful
    end
  end
end
