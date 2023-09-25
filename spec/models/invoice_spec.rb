require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) } 
  it { should have_many(:transactions) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items).through(:invoice_items) }

  describe "class methods" do
    describe "#not_shipped" do
      it "returns only the invoices whose items have not yet shipped" do
        merchant1 = Merchant.create!(name: "Merchant")
        item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
        item2 = merchant1.items.create!(name: "Item 1", description: "Second Item", unit_price: 20)
        item3 = merchant1.items.create!(name: "Item 1", description: "Third Item", unit_price: 30)
        customer1 = Customer.create!(first_name: "Customer 1" , last_name: "Last")
        invoice1 = customer1.invoices.create!(status: 1)
        invoice2 = customer1.invoices.create!(status: 1)
        invoice3 = customer1.invoices.create!(status: 1)
        InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, status: 2)
        InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, status: 1)
        InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, status: 1)

        expect(Invoice.not_shipped).to eq([invoice2, invoice3])
      end
    end

    describe "#discounted_revenue" do
      it "returns total revenue with an applied discount" do

      end
    end
  end

  describe "instance methods" do
    describe "#date_convertion" do
      it "converts the created_at date format to something like 'Wednesday, September 13, 2023'" do
        customer1 = Customer.create!(first_name: "Customer 1" , last_name: "Last")
        invoice1 = customer1.invoices.create!(status: 1, created_at: "Wed, 13 Sep 2023 23:53:41.782461000 UTC +00:00")

        expect(invoice1.date_conversion).to eq("Wednesday, September 13, 2023")
      end
    end
    
    describe "#customer_name" do
      it "converts the frist and last names of the customer into one string" do
        customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
        invoice1 = customer1.invoices.create!(status: 1)

        expect(invoice1.customer_name).to eq("John Smith")
      end
    end

    describe "#total_revenue" do
      it "returns the total revenue this invoice will generate" do
        merchant1 = Merchant.create!(name: "Merchant")
        
        item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
        item2 = merchant1.items.create!(name: "Item 2", description: "Second Item", unit_price: 20)
        item3 = merchant1.items.create!(name: "Item 3", description: "Third Item", unit_price: 30)
        
        customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
       
        invoice1 = customer1.invoices.create!(status: 1)
        
        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 10, status: 2)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: 20, status: 2)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 3, unit_price: 30, status: 2)

        expect(invoice1.total_revenue).to eq(1.40)
      end

      describe "#revenue_with_discounts" do
        it "returns the total revenue for the invoice with any applicable discounts applied" do
          merchant1 = Merchant.create!(name: "Merchant")
          merchant1.bulk_discounts.create!(threshold: 5, discount: 10)
          merchant1.bulk_discounts.create!(threshold: 10, discount: 20)
          item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 100)
          
          customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
         
          invoice1 = customer1.invoices.create!(status: 1)
          
          invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 100, status: 2)
          invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 100, status: 2)
          invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 100, status: 2)

          expect(invoice1.revenue_with_discounts).to eq(13.50)
        end

        it "still returns the non discounted total if no items qualify for bulk_discounts or merchant has 0 discounts made" do
          merchant1 = Merchant.create!(name: "Merchant")
        
          item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
          item2 = merchant1.items.create!(name: "Item 2", description: "Second Item", unit_price: 20)
          item3 = merchant1.items.create!(name: "Item 3", description: "Third Item", unit_price: 30)
          
          customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
         
          invoice1 = customer1.invoices.create!(status: 1)
          
          invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 10, status: 2)
          invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: 20, status: 2)
          invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 3, unit_price: 30, status: 2)
  
          expect(invoice1.revenue_with_discounts).to eq(1.40)
        end
      end
    end
  end
end