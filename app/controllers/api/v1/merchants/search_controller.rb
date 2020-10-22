class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = params.keys[0]
    query = params[attribute].downcase
    render json: MerchantSerializer.new(Merchant.single_find(attribute, query))
  end

  def index
    attribute = params.keys[0]
    query = params[attribute].downcase
    render json: MerchantSerializer.new(Merchant.multi_find(attribute, query))
  end
end