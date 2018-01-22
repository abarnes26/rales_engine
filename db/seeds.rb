# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  require 'csv'

  Invoice.delete_all
  Item.delete_all
  Customer.delete_all
  Merchant.delete_all
  Transaction.delete_all

  customer_csv_text = File.read('./data/customers.csv')
  csv = CSV.parse(customer_csv_text, :headers => true)
  csv.each do |row|
    Customer.create!(row.to_hash)
  end

  merchant_csv_text = File.read('./data/merchants.csv')
  csv = CSV.parse(merchant_csv_text, :headers => true)
  csv.each do |row|
    Merchant.create!(row.to_hash)
  end

  item_csv_text = File.read('./data/items.csv')
  csv = CSV.parse(item_csv_text, :headers => true)
  csv.each do |row|
    Item.create!(row.to_hash)
  end

  invoice_csv_text = File.read('./data/invoices.csv')
  csv = CSV.parse(invoice_csv_text, :headers => true)
  csv.each do |row|
    Invoice.create!(row.to_hash)
  end

  transaction_csv_text = File.read('./data/transactions.csv')
  csv = CSV.parse(transaction_csv_text, :headers => true)
  csv.each do |row|
    Transaction.create!(row.to_hash)
  end

  puts "Seed Complete"
