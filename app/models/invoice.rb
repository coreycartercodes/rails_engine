class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :merchant 
  belongs_to :customer

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.find_total_revenue(start_date, end_date)
    joins(:invoice_items, :transactions)
    .where({transactions: { result: 'success'} }, {invoice_items: {created_at: Date.parse(start_date.to_s).beginning_of_day..Date.parse(end_date.to_s).end_of_day }})
    .select("sum(invoice_items.unit_price * invoice_items.quantity) as revenue")[0]
  end
end
