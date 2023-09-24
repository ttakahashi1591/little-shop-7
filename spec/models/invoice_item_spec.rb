require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    load_test_data
  end
  it { should belong_to :invoice }
  it { should belong_to :item }

  describe "instance methods" do
    describe "#find_item" do
      it "finds and returns item associated with and invoice_item" do
        
        expect(@invoice_item1.find_item).to eq(@item7)
      end
    end

    describe "#find_invoice_items" do
      it "returns all invoice_items associated with given invoice" do

        expect(InvoiceItem.find_invoice_items(@invoice11)).to eq([@invoice_item4])
      end
    end

    describe "#applied_discount" do
      it "returns the ID of the discount that is applied for an invoice_item" do
        merchant = Merchant.create!(name: "dave")
        discount_1 = merchant.bulk_discounts.create!(threshold: 10, discount: 20)
        discount_2 = merchant.bulk_discounts.create!(threshold: 15, discount: 30)
        chochky = merchant.items.create!(name: "chochky", description: "Useless", unit_price: 50)
        customer = Customer.create!(first_name: "John", last_name: "Smith")
        invoice_for_discount = customer.invoices.create!(status: 1, created_at: "2023-08-07")
        invoice_item_with_discount = InvoiceItem.create!(item_id: chochky.id, invoice_id: invoice_for_discount.id, quantity: 10, status: 2)
        
        expect(@invoice_item1.applied_discount).to eq(nil)
        expect(invoice_item_with_discount.applied_discount).to eq(discount_1.id)
      end
    end
  end
end