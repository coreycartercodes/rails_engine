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
    joins(invoices: [:transactions, :invoice_items])
    .where({invoices: {merchant_id: id} }, { transactions: { result: 'success'} })
    .select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group("merchants.id").first
  end

  def self.find_most_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
    .where({transactions: { result: 'success'} })
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.find_most_items(quant)
    joins(invoices: [:transactions, :invoice_items])
    .where({transactions: { result: 'success'} })
    .select("merchants.*, sum(invoice_items.quantity) as item_count")
    .group(:id)
    .order("item_count DESC")
    .limit(quant)
  end

end
