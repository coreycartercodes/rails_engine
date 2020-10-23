class Api::V1::RevenueController < ApplicationController

  def index
    binding.pry
    render json: RevenueSerializer.new(InvoiceItem.find_total_revenue(params[:start], params[:end]))
  end

end