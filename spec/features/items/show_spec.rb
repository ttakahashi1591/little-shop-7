require 'rails_helper'

RSpec.describe "Items Show Page", type: :feature do
  before(:each) do 
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
  end

  it "shows all of the item's attributes" do 
    visit "/items/#{@item.id}"

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
  end
end