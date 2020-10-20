class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(@merchant.items)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    new_item = Item.create(item_params)
    render json: ItemSerializer.new(new_item) if new_item.save
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    render json: Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end