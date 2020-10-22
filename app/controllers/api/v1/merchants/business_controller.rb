class Api::V1::Merchants::BusinessController < ApplicationController

def most_revenue

  render json: MerchantSerializer.new(Merchant.all)
end

def revenue
  id = params[:id]
  render json: MerchantSerializer.new(Merchant.merchant_revenue(id))
end

end