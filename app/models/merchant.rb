class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices


  def self.single_find(attribute, query)
    Merchant.where("LOWER(#{attribute}) LIKE ?", "%#{query}%").first
  end

  def self.multi_find(attribute, query)
    Merchant.where("LOWER(#{attribute}) LIKE ?", "%#{query}%")
  end

  def self.merchant_revenue(id)
    self.joins(invoices: [:transactions, :invoice_items]).select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where({invoices: { status: 'shipped', merchant_id: id} }, { transactions: { result: 'success'} }).group("merchants.id").first
  end
end
