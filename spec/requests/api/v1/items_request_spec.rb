require 'rails_helper'

RSpec.describe 'Items API' do
  it 'sends a list of items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)
    expect(items[:data]).to be_a(Array)
    expect(items[:data][0][:attributes]).to be_a(Hash)
  end

  it 'gets an item by its id' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id.to_s

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item).to be_a(Hash)
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(id)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = {
      "name": 'Washing Machine',
      "description": 'Washes clothes',
      "unit_price": 500.0,
      "merchant_id": merchant.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end

  it 'can update an existing item' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id
    previous_name = Item.last.name
    item_params = { name: 'Dishwasher' }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('Dishwasher')
  end

  it 'can delete an existing item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
  end
end
