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
  puts 'the deed is done'