class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description, :unit_price
  # before_save { |item| item.unit_price = calculate_price }

  def self.single_find(attribute, query)
    Item.where("LOWER(#{attribute}) LIKE ?", "%#{query}%").first
  end

  def self.multi_find(attribute, query)
    Item.where("LOWER(#{attribute}) LIKE ?", "%#{query}%")
  end

  private

  # def calculate_price
  #   (unit_price / 100).to_f
  # end

end
