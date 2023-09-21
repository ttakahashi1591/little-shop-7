require 'rails_helper'

RSpec.describe "Merchant Discounts Index Page", type: :feature do
  before :each do 
    load_test_data
  end

  it "can see all the merchant's bulk discounts including their percentage discount and quantity thresholds" do

    visit "/merchants/#{@merchant_1.id}/discounts"

    expect(page)
  end
end