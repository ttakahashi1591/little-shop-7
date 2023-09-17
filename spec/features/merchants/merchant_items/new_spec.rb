require 'rails_helper'

RSpec.describe "Merchant Items Creation Page", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @item = create(:item, merchant: @merchant)
  end

  it "has fields to fill in" do 
    visit "/merchants/#{@merchant.id}/items"

    click_link("Create New Item")

    expect(page).to have_field("Name")
    expect(page).to have_field("Description")
    expect(page).to have_field("Unit price")
  end

  it "can save item to merchant index page with a default status of disabled" do 
    visit "/merchants/#{@merchant.id}/items"

    click_link("Create New Item")

    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description"
    fill_in "Unit price", with: 20

    click_button("Submit")
    
    expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("New name")
  end
end