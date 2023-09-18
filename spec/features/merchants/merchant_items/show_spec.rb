require 'rails_helper'

RSpec.describe "Merchant Items Show Page", type: :feature do
  before(:each) do 
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
  end

  it "shows all of the item's attributes" do 
    visit merchant_item_path(@merchant, @item)

    expect(page).to have_current_path(merchant_item_path(@merchant, @item))

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)

    expect(page).to have_link("Update")
  end
end