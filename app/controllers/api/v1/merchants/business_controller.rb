class Api::V1::Merchants::BusinessController < ApplicationController

  def most_revenue
    render json: MerchantSerializer.new(Merchant.find_most_revenue(params[:quantity]))
  end

  def revenue
    render json: RevenueSerializer.new(Merchant.merchant_revenue(params[:id]))
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.find_most_items(params[:quantity]))
  end

end