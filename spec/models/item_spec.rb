require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe "instance methods" do
    before :each do
      @merchant = Merchant.create!(name: "Merchant")
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)
      @merchant5 = create(:merchant)
      
      @item1 = @merchant.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
      @item2 = @merchant.items.create!(name: "Item 1", description: "Second Item", unit_price: 20)
      @item3 = @merchant.items.create!(name: "Item 1", description: "Third Item", unit_price: 30)
      
      @customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
      
      @invoice1 = @customer1.invoices.create!(status: 1)
      
      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, status: 2)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, status: 2)
      @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, status: 2)
    end

    describe "#quantity(invoice.id)" do
      it "returns the invoice_items quantity for the item with the passed in invoice.id" do
        expect(@item1.quantity(@invoice1.id)).to eq(@invoice_item1.quantity)
        expect(@item2.quantity(@invoice1.id)).to eq(@invoice_item2.quantity)
        expect(@item3.quantity(@invoice1.id)).to eq(@invoice_item3.quantity)
      end
    end

    describe "#status(invoice.id)" do
      it "returns the invoice_items status for the item with the passed in invoice.id" do
        expect(@item1.invoice_status(@invoice1.id)).to eq(@invoice_item1.status)
        expect(@item2.invoice_status(@invoice1.id)).to eq(@invoice_item2.status)
        expect(@item3.invoice_status(@invoice1.id)).to eq(@invoice_item3.status)
      end
    end
  end

  describe "#class methods" do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)
      @merchant5 = create(:merchant)
      @merchant6 = create(:merchant)
      
      @item1 = create(:item, unit_price: 10, merchant_id: @merchant1.id)
      @item2 = create(:item, unit_price: 50, merchant_id: @merchant2.id)
      @item3 = create(:item, unit_price: 100, merchant_id: @merchant3.id)
      @item4 = create(:item, unit_price: 200, merchant_id: @merchant4.id)
      @item5 = create(:item, unit_price: 300, merchant_id: @merchant5.id)
      @item6 = create(:item, unit_price: 400, merchant_id: @merchant6.id)
      
      @customer = Customer.create!(first_name: "John", last_name: "Smith")
      @invoice1 = @customer.invoices.create!(status: 1, created_at: "2023-08-07")
      @invoice2 = @customer.invoices.create!(status: 1, created_at: "2023-08-08")
      @invoice3 = @customer.invoices.create!(status: 1, created_at: "2023-08-11")
      @invoice4 = @customer.invoices.create!(status: 1, created_at: "2023-08-12")
      @invoice5 = @customer.invoices.create!(status: 1, created_at: "2023-08-14")
      @invoice6 = @customer.invoices.create!(status: 1, created_at: "2023-08-15")
      @invoice7 = @customer.invoices.create!(status: 1, created_at: "2023-08-09")
      @invoice8 = @customer.invoices.create!(status: 1, created_at: "2023-08-09")
      @invoice9 = @customer.invoices.create!(status: 1, created_at: "2023-08-12")
      @invoice10 = @customer.invoices.create!(status: 1, created_at: "2023-08-12")

      
      InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice6.id, quantity: 7, unit_price: 400, status: 2)
      InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 6, unit_price: 300, status: 2)
      InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 4, unit_price: 200, status: 2)
      InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 3, unit_price: 100, status: 2)
      InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 50, status: 2)
      InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10, status: 2)
      
      InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice7.id, quantity: 1, unit_price: 10, status: 2)
      InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice8.id, quantity: 1, unit_price: 10, status: 2)
      InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice9.id, quantity: 1, unit_price: 50, status: 2)
      InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice10.id, quantity: 1, unit_price: 50, status: 2)

      @invoice1.transactions.create!(result: 1)
      @invoice2.transactions.create!(result: 1)
      @invoice3.transactions.create!(result: 1)
      @invoice3.transactions.create!(result: 1)
      @invoice4.transactions.create!(result: 1)
      @invoice5.transactions.create!(result: 1)
      @invoice6.transactions.create!(result: 1)
      @invoice7.transactions.create!(result: 1)
      @invoice8.transactions.create!(result: 1)
      @invoice9.transactions.create!(result: 1)
      @invoice10.transactions.create!(result: 1)
    end

    describe "#self.enabled, self.disabled" do
      it "returns items that are enabled/disabled" do
        enabled_item = create(:item, status: :enabled)
        disabled_item = create(:item)

        enabled_items = Item.enabled
        disabled_items = Item.disabled

        expect(enabled_items).to include(enabled_item)
        expect(enabled_items).not_to include(disabled_item)
        expect(disabled_items).to include(disabled_item)
        expect(disabled_items).not_to include(enabled_item)
      end
    end

    describe "#top_5_items" do
      it "returns the top 5 items based on revenue" do
        expect(Item.top_5_items).to eq([@item6, @item5, @item4, @item3, @item2])
      end
    end

    describe "#total_revenue" do 
      it "gives the total overall revenue for that item" do
        expect(@item6.item_total_revenue).to eq(2800)
        expect(@item5.item_total_revenue).to eq(1800)
        expect(@item4.item_total_revenue).to eq(800)
        expect(@item3.item_total_revenue).to eq(300)
        expect(@item2.item_total_revenue).to eq(200)
      end
    end

    describe "#item_best_day" do 
      it "shows the best day of sales for that item" do
        expect(@item1.item_best_day).to eq("Wed, 09 Aug 2023")
        expect(@item2.item_best_day).to eq("Tue, 08 Aug 2023")
        expect(@item3.item_best_day).to eq("Fri, 11 Aug 2023")
        expect(@item4.item_best_day).to eq("Sat, 12 Aug 2023")
        expect(@item5.item_best_day).to eq("Mon, 14 Aug 2023")
        expect(@item6.item_best_day).to eq("Tue, 15 Aug 2023")
      end
    end
  end
end