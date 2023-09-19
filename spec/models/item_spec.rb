require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe "instance methods" do
    before :each do
      load_test_data
    end

    describe "#quantity(invoice.id)" do
      it "returns the invoice_items quantity for the item with the passed in invoice.id" do
        expect(@item7.quantity(@invoice_1.id)).to eq(@invoice_item1.quantity)
        expect(@item8.quantity(@invoice_1.id)).to eq(@invoice_item2.quantity)
        expect(@item9.quantity(@invoice_1.id)).to eq(@invoice_item3.quantity)
      end
    end

    describe "#status(invoice.id)" do
      it "returns the invoice_items status for the item with the passed in invoice.id" do
        expect(@item7.invoice_status(@invoice_1.id)).to eq(@invoice_item1.status)
        expect(@item8.invoice_status(@invoice_1.id)).to eq(@invoice_item2.status)
        expect(@item9.invoice_status(@invoice_1.id)).to eq(@invoice_item3.status)
      end
    end
  end

  describe "#class methods" do
    before :each do
      load_test_data
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