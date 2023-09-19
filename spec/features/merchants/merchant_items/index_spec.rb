require 'rails_helper'

RSpec.describe "Merchant Items Index Page", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @merchant_2 = create(:merchant)
    @items_2 = create_list(:item, 3, merchant: @merchant_2)
    @item = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @enabled_items = create_list(:item, 3, merchant: @merchant, status: 'enabled')
    @disabled_items = create_list(:item, 3, merchant: @merchant, status: 'disabled')
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)
      
    @item1 = create(:item, unit_price: 10, merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 50, merchant_id: @merchant2.id)
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant3.id)
    @item4 = create(:item, unit_price: 200, merchant_id: @merchant4.id)
    @item5 = create(:item, unit_price: 300, merchant_id: @merchant5.id)
    @item6 = create(:item, unit_price: 400, merchant_id: @merchant6.id)
      
    @customer = Customer.create!(first_name: "John", last_name: "Smith")
    @invoice1 = @customer.invoices.create!(status: 1, created_at: "2023-08-07")
    @invoice2 = @customer.invoices.create!(status: 1, created_at: "2023-08-10")
    @invoice3 = @customer.invoices.create!(status: 1, created_at: "2023-08-11")
    @invoice4 = @customer.invoices.create!(status: 1, created_at: "2023-08-14")
    @invoice5 = @customer.invoices.create!(status: 1, created_at: "2023-08-21")
    @invoice6 = @customer.invoices.create!(status: 1, created_at: "2023-08-24")
      
    InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice6.id, quantity: 7, unit_price: 400, status: 2)
    InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 6, unit_price: 300, status: 2)
    InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 4, unit_price: 200, status: 2)
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 3, unit_price: 100, status: 2)
    InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 50, status: 2)
    InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10, status: 2)
      
    @invoice1.transactions.create!(result: 1)
    @invoice2.transactions.create!(result: 1)
    @invoice3.transactions.create!(result: 1)
    @invoice3.transactions.create!(result: 1)
    @invoice4.transactions.create!(result: 1)
    @invoice5.transactions.create!(result: 1)
    @invoice6.transactions.create!(result: 1)
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
      expect(page).to have_content("Top selling date for this item: Thu, 24 Aug 2023")
    end

    within("#item-#{@item5.id}") do 
      expect(page).to have_content("Top selling date for this item: Mon, 21 Aug 2023")
    end

    within("#item-#{@item4.id}") do 
      expect(page).to have_content("Top selling date for this item: Mon, 14 Aug 2023")
    end

    within("#item-#{@item3.id}") do 
      expect(page).to have_content("Top selling date for this item: Fri, 11 Aug 2023")
    end
  end
end