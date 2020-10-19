# frozen_string_literal: true

require 'rails_helper'

describe 'Items API' do
  before :each do
    @merchant = create :merchant
  end

  it 'Can retrieve all items' do
    create_list(:item, 3, merchant_id: @merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    id = create(:item, merchant_id: @merchant.id).id
  
    get "/api/v1/items/#{id}"
  
    item = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)
  
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
  
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
  
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
  end

  it 'Can create an item' do
    item_params = { name: 'Thing1', description: 'One of the things', unit_price: 1.50, merchant_id: @merchant.id}

    post '/api/v1/items', params: { item: item_params }

    expect(response).to be_successful

    item = Item.last
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq((item_params[:unit_price]/100).to_f)
  end

  it "can update an existing item" do
    id = create(:item, merchant_id: @merchant.id).id
    previous_name = Item.last.name
    item_params = { name: "Thing2" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Thing2")
  end

  it "can destroy an item" do
    item = create(:item, merchant_id: @merchant.id)
  
    expect(Item.count).to eq(1)
  
    delete "/api/v1/items/#{item.id}"
  
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
