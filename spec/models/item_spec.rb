require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: "Merchant")
      
      @item1 = @merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
      @item2 = @merchant1.items.create!(name: "Item 1", description: "Second Item", unit_price: 20)
      @item3 = @merchant1.items.create!(name: "Item 1", description: "Third Item", unit_price: 30)
      
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
  end
end