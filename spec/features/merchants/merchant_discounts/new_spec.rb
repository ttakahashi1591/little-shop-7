require 'rails_helper'

RSpec.describe "Merchant Discounts Index Page", type: :feature do
  before :each do 
    load_test_data
    @discount = @merchant.discounts.create(percent: 20, quantity_threshold: 2)
  end

  it "has fields to fill in to create a new discount" do 
    visit new_merchant_discount_path(@merchant)

    within ('.discount_new_header') do 
      expect(page).to have_content("Create A New Discount:")
    end

    within ('.create_form') do 
      expect(page).to have_field("Percent")
      expect(page).to have_field("Quantity threshold")
    end
  end

  it "when filled in with valid data, user is redirected to merchant discount index page with the new bulk discount listed" do 
    visit new_merchant_discount_path(@merchant)

    fill_in "Percent", with: "20"
    fill_in "Quantity threshold", with: "10"

    click_button("Submit")

    expect(page).to have_current_path(merchant_discounts_path(@merchant))
    expect(page).to have_content("Discount Percentage: 20")
    expect(page).to have_content("Quantity Threshold: 10")
  end

  it "when not filled in with valid data, user is prompted to fill in all fields" do 
    visit new_merchant_discount_path(@merchant)

    fill_in "Quantity threshold", with: "10"

    click_button("Submit")

    expect(page).to have_current_path(merchant_discounts_path(@merchant))
    expect(page).to have_content("Fill in all fields.")
  end
end
