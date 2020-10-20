class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
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
    render json: Merchant.destroy(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end

end