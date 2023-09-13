require 'rails_helper'

RSpec.describe "Merchant Items Index Page", type: :feature do
  before do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
  end

  it "displays only the items for the current merchant" do
    visit "/merchants/#{@merchant.id}/items"

    @items.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.unit_price)
    end
    save_and_open_page
  end
end