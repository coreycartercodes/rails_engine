class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys[0]
    query = params[attribute].downcase
    render json: ItemSerializer.new(Item.single_find(attribute, query))
  end
  
  def index
    attribute = params.keys[0]
    query = params[attribute].downcase
    render json: ItemSerializer.new(Item.multi_find(attribute, query))
  end
end