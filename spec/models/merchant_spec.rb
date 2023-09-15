require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dude")
    @merchant_2 = Merchant.create!(name: "Bubba's Boutique")
    @chochky = @merchant_1.items.create!(name: "chochky", description: "Useless", unit_price: 50)
    @spinner = @merchant_2.items.create!(name: "Fidget Spinner", description: "Spins", unit_price: 1)
    @bouncer = @merchant_2.items.create!(name: "Bouncy Ball", description: "bounces", unit_price: 2)

    @cust_1 = Customer.create!(first_name: "Dave", last_name: "Beckam")
    @cust_2 = Customer.create!(first_name: "Becky", last_name: "Beckam")
    @cust_3 = Customer.create!(first_name: "Steve", last_name: "Beckam")
    @cust_4 = Customer.create!(first_name: "Roger", last_name: "Beckam")
    @cust_5 = Customer.create!(first_name: "Winnona", last_name: "Beckam")
    @cust_6 = Customer.create!(first_name: "Bend_it", last_name: "Beckam")
    5.times { @cust_1
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    4.times { @cust_3
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    3.times { @cust_2
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    2.times { @cust_5
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @bouncer.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: @spinner.id)
              .invoice.transactions.create!(result: 0)
            }
  end
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "#top_5_customers" do
    it "returns the top 5 customers with most successful transactions for a merchant" do
      expect(@merchant_1.top_5_customers_sql).to eq([@cust_1, @cust_3, @cust_2, @cust_5, @cust_4])
    end
  end

  describe "#items_ready_to_ship" do
    it "returns a list of items that have successful transactions, status is packaged
    and invoice is either completed or in progress" do
      expect(@merchant_2.items_ready_to_ship).to eq([@bouncer])
    end
  end
end