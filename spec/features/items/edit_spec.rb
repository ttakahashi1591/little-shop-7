require 'rails_helper'

RSpec.describe "Items Edit Page", type: :feature do
  before(:each) do 
    @merchant = create(:merchant)
    @item = Item.create(name: "Unit Name", description: "Unit Description", unit_price: 10, status: 0, merchant_id: @merchant.id)
  end

  it "edit page has a form to edit existing item attribute information" do 
    visit "/items/#{@item.id}/edit"

    expect(page).to have_current_path("/items/#{@item.id}/edit")
    expect(page).to have_field("Name")
    expect(page).to have_field("Description")
    expect(page).to have_field("Unit price")

    expect(find_field("Name").value).to eq("Unit Name")
    expect(find_field("Description").value).to eq("Unit Description")
    expect(find_field("Unit price").value).to eq("10")
  end

  it "item info field can be filled in" do 
    visit "/items/#{@item.id}/edit"

    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description"
    fill_in "Unit price", with: 20
    
    expect(find_field("Name").value).to eq("New name")
    expect(find_field("Description").value).to eq("New description")
    expect(find_field("Unit price").value).to eq("20")
  end

  it "when info is updated and submitted, receive success flash message and be redirected to item show page" do 
    visit "/items/#{@item.id}/edit"

    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description"
    fill_in "Unit price", with: 20

    click_button("Submit")
    expect(page).to have_content("Item successfully updated!")
    expect(page).to have_current_path("/items/#{@item.id}")
  end
end