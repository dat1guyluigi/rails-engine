require 'rails_helper'

RSpec.describe 'Merchants Items' do
  describe 'happy path' do
    it 'returns all merchants items' do
      merchant = create(:merchant, id: 1)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)

      get '/api/v1/merchants/1/items'
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant.class).to eq(Hash)
    end
  end
end
