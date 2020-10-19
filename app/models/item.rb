class Item < ApplicationRecord
  belongs_to :merchant
  before_save { |item| item.unit_price = calculate_price }

  private

  def calculate_price
    (unit_price / 100).to_f
  end

end
