class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :quantity, :unit_price


  def find_total_revenue(start_date, end_date)
    binding.pry
  end
end
