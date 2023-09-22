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
    it { should have_many(:discounts) }
  end

  describe "#top_5_customers" do
    it "returns the top 5 customers with most successful transactions for a merchant" do
      expect(@merchant_1.top_5_customers_sql).to eq([@cust_1, @cust_3, @cust_2, @cust_5, @cust_4])
      expect(@merchant_1.top_5_customers.first.first_name).to eq(@cust_1.first_name)
    end
  end

  describe "#items_ready_to_ship" do
    it "returns a list of items that have successful transactions, status is packaged
    and invoice is either completed or in progress" do
      expect(@merchant_2.items_ready_to_ship).to eq([@bouncer])
      expect(@merchant_2.items_ready_to_ship.first.ordered_on_date).to eq(@merchant_2.items_ready_to_ship.first.ordered_on_date)
    end
  end

  describe "#best_day" do
    it "returns the best day for the merchant" do
      best_day = @merchant_1.best_day

      parsed_date = Date.parse(best_day)
      expected_formatted_date = parsed_date.strftime("%A, %B %d, %Y")

      expect(best_day).to eq(expected_formatted_date)    
    end
  end

  describe "#class methods" do
    describe "#top_5" do
      it "returns the top 5 merchants based on revenue" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
        merchant4 = create(:merchant)
        merchant5 = create(:merchant)
        merchant6 = create(:merchant)
        item1 = create(:item, unit_price: 100, merchant_id: merchant1.id)
        item2 = create(:item, unit_price: 100, merchant_id: merchant2.id)
        item3 = create(:item, unit_price: 100, merchant_id: merchant3.id)
        item4 = create(:item, unit_price: 100, merchant_id: merchant4.id)
        item5 = create(:item, unit_price: 100, merchant_id: merchant5.id)
        item6 = create(:item, unit_price: 100, merchant_id: merchant6.id)
        customer = Customer.create!(first_name: "John", last_name: "Smith")
        invoice1 = customer.invoices.create!(status: 1)
        invoice2 = customer.invoices.create!(status: 1)
        invoice3 = customer.invoices.create!(status: 1)
        invoice4 = customer.invoices.create!(status: 1)
        invoice5 = customer.invoices.create!(status: 1)
        invoice6 = customer.invoices.create!(status: 1)
        InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 3, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 5, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 2, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 6, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 100, status: 2)
        invoice1.transactions.create!(result: 1)
        invoice2.transactions.create!(result: 0)
        invoice3.transactions.create!(result: 0)
        invoice3.transactions.create!(result: 1)
        invoice4.transactions.create!(result: 1)
        invoice5.transactions.create!(result: 1)
        invoice6.transactions.create!(result: 1)

        expect(Merchant.top_5).to eq([merchant3, merchant5, merchant1, merchant6, merchant4])
      end
    end
  end
end