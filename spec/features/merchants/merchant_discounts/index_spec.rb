require 'rails_helper'

RSpec.describe "Merchant Discounts Index Page", type: :feature do
  before :each do 
    load_test_data
  end

  it "can see all the merchant's bulk discounts including their percentage discount and quantity thresholds" do

    visit "/merchants/#{@merchant_1.id}/discounts"

    within(".discount_index_header") do
      expect(page).to have_content("All Bulk Discounts")
    end

    within(".discount_")
  end
end