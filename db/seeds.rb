# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "CSV"

CSV.foreach('./db/csv_seeds/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  name = row[:name]
  Merchant.create!({id: id, name: name})
end

CSV.foreach('./db/csv_seeds/data/items.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  name = row[:name]
  description = row[:description]
  unit_price = ((row[:unit_price].to_f)/100.round(2))
  merchant_id = row[:merchant_id].to_i
  Item.create!({id: id, name: name, description: description, unit_price: unit_price, merchant_id: merchant_id})
end

CSV.foreach('./db/csv_seeds/data/customers.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  first_name = row[:first_name]
  last_name = row[:last_name]
  Customer.create!({id: id, first_name: first_name, last_name: last_name})
end

CSV.foreach('./db/csv_seeds/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  customer_id = row[:customer_id].to_i
  merchant_id = row[:merchant_id].to_i
  status = row[:status]
  created_at = row[:created_at]
  Invoice.create!({id: id, customer_id: customer_id, merchant_id: merchant_id, status: status, created_at: created_at})
end

CSV.foreach('./db/csv_seeds/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  invoice_id = row[:invoice_id].to_i
  credit_card_number = row[:credit_card_number]
  credit_card_expiration_date = row[:credit_card_expiration_date]
  result = row[:result]
  created_at = row[:created_at]
  Transaction.create!({id: id, invoice_id: invoice_id, credit_card_number: credit_card_number, credit_card_expiration_date: credit_card_expiration_date, result: result, created_at: created_at})
end

CSV.foreach('./db/csv_seeds/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  item_id = row[:item_id].to_i
  invoice_id = row[:invoice_id].to_i
  quantity = row[:quantity].to_i
  unit_price = ((row[:unit_price].to_f)/100.round(2))
  InvoiceItem.create!({id: id, item_id: item_id, invoice_id: invoice_id, quantity: quantity, unit_price: unit_price})
end


  puts 'the deed is done'