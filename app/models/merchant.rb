class Merchant < ApplicationRecord
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

  end
end
