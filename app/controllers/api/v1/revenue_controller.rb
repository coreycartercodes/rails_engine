class Api::V1::RevenueController < ApplicationController

  def index
    render json: RevenueSerializer.new(Invoice.find_total_revenue(params[:start], params[:end]))
  end

end