class Api::V1::MerchantsController < ApplicationController

  def index
    if params[:item_id]
      @item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(@item.merchant)
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    new_merchant = Merchant.new(merchant_params)
    render json: MerchantSerializer.new(new_merchant) if new_merchant.save
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    Merchant.destroy(params[:id])
    head :no_content
  end

  private

  def merchant_params
    params.permit(:name)
  end
end