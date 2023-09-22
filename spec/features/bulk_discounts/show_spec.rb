require 'rails_helper'

RSpec.describe "Bulk Discounts index page", type: :feature do
  before(:each) do
    load_test_data
  end
  describe "As a visitor" do
    describe "When I visit /merchants/:merchant_id/bulk_discounts/:bulk_discount_id" do
      it "Then I see the bulk discount's quantity threshold and percentage discount" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@discount_1.id}"

        expect(page).to have_content("Threshold: #{@discount_1.threshold}")
        expect(page).to have_content("Discount: #{@discount_1.discount}")
      end
    end
  end
end