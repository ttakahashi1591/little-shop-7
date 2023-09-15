require 'rails_helper'

RSpec.describe "Merchant Items Index Page", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @merchant_2 = create(:merchant)
    @items_2 = create_list(:item, 3, merchant: @merchant_2)
    @item = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
  end

  it "displays only the items for the current merchant" do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content("Items for #{@merchant.name}")
    expect(page).to_not have_content("Items for #{@merchant_2.name}")

    @items.each do |item|
      expect(page).to have_link(item.name)
      expect(page).to have_content(item.name)
    end

    @items_2.each do |item|
      expect(page).to_not have_content(item.name)
    end
  end

  it "next to each item, there is a button to enable or disable that item" do
    visit "/merchants/#{@merchant.id}/items"

    within("#item-#{@item.id}") do
      select 'enabled', from: 'Item Status:'
      click_button "Update Item Status"
    end
    
    expect(page).to have_current_path("/merchants/#{@merchant.id}/items")

    within("#item-#{@item.id}") do
      expect(page).to have_content("Current Status: enabled")
    end

    within("#item-#{@item_2.id}") do
      expect(page).to have_content("Current Status: disabled")
    end
  end
end