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
    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    id = create(:item, merchant_id: @merchant.id).id
  
    get "/api/v1/items/#{id}"
  
    item = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(id.to_s)
  
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
  
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
  
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  end

  it 'Can create an item' do
    item_params = { name: 'Thing1', description: 'One of the things', unit_price: 1.50, merchant_id: @merchant.id}

    post '/api/v1/items', params: item_params

    expect(response).to be_successful

    item = Item.last
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq((item_params[:unit_price]).to_f)
  end

  it "can update an existing item" do
    id = create(:item, merchant_id: @merchant.id).id
    previous_name = Item.last.name
    item_params = { name: "Thing2" }
    # headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{id}", params: item_params
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

  it 'can show merchant related to items' do
    id = create(:item, merchant_id: @merchant.id).id
    get "/api/v1/items/#{id}/merchants"
  
    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json[:data][:id]).to eq(@merchant.id.to_s)
  end

  it 'can search for a single item based on a match' do
    item1 = create(:item, {name: "Susan Sarandon", merchant_id: @merchant.id})
    item2 = create(:item, {name: "Tim Allen", merchant_id: @merchant.id})
    item3 = create(:item, {name: "Sally Suspicious", merchant_id: @merchant.id})
    search_params = {'name' => 'sus'}
    get "/api/v1/items/find", params: search_params

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:id]).to eq(item1.id.to_s)
  end
end
