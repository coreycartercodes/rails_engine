class Item < ApplicationRecord
  belongs_to :merchant
  # validates_presence_of :id, :name, :description, :unit_price, :merchant_id
  # before_save { |item| item.unit_price = calculate_price }

  private

  # def calculate_price
  #   (unit_price / 100).to_f
  # end

end
