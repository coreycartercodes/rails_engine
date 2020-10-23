class Api::V1::Merchants::BusinessController < ApplicationController

def most_revenue

  render json: MerchantSerializer.new(Merchant.all)
end

def revenue
  render json: RevenueSerializer.new(Merchant.merchant_revenue(params[:id]))
end

end