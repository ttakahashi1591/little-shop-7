require 'rails_helper'

RSpec.describe "Merchant Items Index Page", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @merchant_2 = create(:merchant)
    @items_2 = create_list(:item, 3, merchant: @merchant_2)
  end

  it "displays only the items for the current merchant" do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content("Items for #{@merchant.name}")
    expect(page).to_not have_content("Items for #{@merchant_2.name}")
    
    @items.each do |item|
      expect(page).to have_link(item.name)
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.unit_price)
    end

    @items_2.each do |item|
      expect(page).to_not have_content(item.name)
    end
  end
end