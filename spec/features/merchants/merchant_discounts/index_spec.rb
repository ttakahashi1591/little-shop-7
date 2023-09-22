require 'rails_helper'

RSpec.describe "Merchant Discounts Index Page", type: :feature do
  before :each do 
    load_test_data
    @discount = @merchant.discounts.create(percent: 20, quantity_threshold: 2)
    @discount2 = @merchant.discounts.create(percent: 10, quantity_threshold: 1)
  end

  it "can see all the merchant's bulk discounts including their percentage discount and quantity thresholds" do

    visit "/merchants/#{@merchant.id}/discounts"

    within(".discount_index_header") do
      expect(page).to have_content("All Bulk Discounts")
    end

    within("#discount-#{@discount.id}") do
      expect(page).to have_content("Discount ID:")
      expect(page).to have_content(@discount.id)
      expect(page).to_not have_content("#{@discount2.id}")
      expect(page).to have_content("Discount Percentage:")
      expect(page).to have_content(@discount.percent)
      expect(page).to have_content("Quantity Threshold:")
      expect(page).to have_content(@discount.quantity_threshold)
    end

    within("#discount-#{@discount2.id}") do
      expect(page).to have_content("Discount ID:")
      expect(page).to have_content(@discount2.id)
      expect(page).to_not have_content("#{@discount.id}")
      expect(page).to have_content("Discount Percentage:")
      expect(page).to have_content(@discount2.percent)
      expect(page).to have_content("Quantity Threshold:")
      expect(page).to have_content(@discount2.quantity_threshold)
    end
  end

  it "next to each discount includes a link that when clicked, redirects user to the show page for that discount" do 

    visit "/merchants/#{@merchant.id}/discounts"

    within("#discount-#{@discount.id}") do
      expect(page).to have_link("Page for this Discount")
    end

    within("#discount-#{@discount2.id}") do
      expect(page).to have_link("Page for this Discount")
    end

    within("#discount-#{@discount.id}") do
      click_link("Page for this Discount")
      expect(page).to have_current_path(merchant_discount_path(@merchant, @discount))
    end
  end

  it "there is a link to create a new discount" do 

    visit "/merchants/#{@merchant.id}/discounts"

    within(".discount_create_link") do
      expect(page).to have_link("Create New Discount")
    end
  end

  it "when user clicks this link, is redirected to page with form to create a new discount" do 
    
    visit "/merchants/#{@merchant.id}/discounts"

    click_link("Create New Discount")

    expect(page).to have_current_path(new_merchant_discount_path(@merchant))
  end
end