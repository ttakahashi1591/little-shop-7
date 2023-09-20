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
  end
end