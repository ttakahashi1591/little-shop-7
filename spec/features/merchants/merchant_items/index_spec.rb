require 'rails_helper'

RSpec.describe "Merchant Items Index Page", type: :feature do
  before(:each) do
    load_test_data
  end

  it "displays only the items for the current merchant" do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content("Items for #{@merchant.name}")
    expect(page).to_not have_content("Items for #{@merchant2.name}")

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
  end

  it "there are two sections, one for enabled items and one for disabled items" do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content("Enabled Items")
    expect(page).to have_content("Disabled Items")

    within("table#enabled-items") do
      @enabled_items.each do |item|
        expect(page).to have_content(item.name)
      end
    end

    within("table#disabled-items") do
      @disabled_items.each do |item|
        expect(page).to have_content(item.name)
      end
    end
  end

  it "has a link that has a page to create a new item" do 
    visit "/merchants/#{@merchant.id}/items"
    expect(page).to have_link("Create New Item")

    click_link("Create New Item")

    expect(page).to have_current_path("/merchants/#{@merchant.id}/items/new")
  end

  it "see the names of the top 5 most popular items ranked by total revenue generated" do
    visit "/merchants/#{@merchant.id}/items"
    
    expect(page).to have_content("Top 5 Most Popular Items")

    within('.top_5_list') do 
      expect(@item6.name).to appear_before(@item5.name)
      expect(@item5.name).to appear_before(@item4.name)
      expect(@item4.name).to appear_before(@item3.name)
      expect(@item3.name).to appear_before(@item2.name)
    end

    within("#item-#{@item6.id}") do 
      expect(page).to have_content("Top selling date for this item: Tue, 15 Aug 2023")
    end

    within("#item-#{@item5.id}") do 
      expect(page).to have_content("Top selling date for this item: Mon, 14 Aug 2023")
    end

    within("#item-#{@item4.id}") do 
      expect(page).to have_content("Top selling date for this item: Sat, 12 Aug 2023")
    end

    within("#item-#{@item3.id}") do 
      expect(page).to have_content("Top selling date for this item: Fri, 11 Aug 2023")
    end

    within("#item-#{@item2.id}") do 
      expect(page).to have_content("Top selling date for this item: Tue, 08 Aug 2023")
    end
  end
end