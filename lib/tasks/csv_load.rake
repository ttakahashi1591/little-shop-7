require 'csv'

namespace :csv_load do
  task :customers => :environment do
    path = Rails.root.join("db", "data", "customers.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| Customer.create!(id: row[:id], first_name: row[:first_name], last_name: row[:last_name])}
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  
  task :invoice_items => :environment do
    path = Rails.root.join("db", "data", "invoice_items.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| InvoiceItem.create!(id: row[:id], item_id: row[:item_id], invoice_id: row[:invoice_id], quantity: row[:quantity], unit_price: row[:unit_price], status: row[:status])}
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task :invoices => :environment do
    path = Rails.root.join("db", "data", "invoices.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| Invoice.create!(id: row[:id], customer_id: row[:customer_id], status: row[:status])}
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task :items => :environment do
    path = Rails.root.join("db", "data", "items.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| Item.create!(id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], merchant_id: row[:merchant_id])}
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task :merchants => :environment do
    path = Rails.root.join("db", "data", "merchants.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| Merchant.create!(id: row[:id], name: row[:name])}
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task :transactions => :environment do
    path = Rails.root.join("db", "data", "transactions.csv")
    csv = CSV.foreach(path, headers: true, header_converters: :symbol) { |row| Transaction.create!(id: row[:id], invoice_id: row[:invoice_id], credit_card_number: row[:credit_card_number], credit_card_expiration_date: row[:credit_card_expiration_date], result: row[:result])}
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task :all => :environment do
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:transactions'].execute
    Rake::Task['csv_load:invoice_items'].execute
  end
end
