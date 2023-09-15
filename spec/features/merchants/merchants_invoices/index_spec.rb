require 'rails_helper'

RSpec.describe "Merchant Invoices index", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Geoff's Goodies")
    @merchant_2 = Merchant.create!(name: "Bubba's Boutique")
    @chochky = @merchant_1.items.create!(name: "chochky", description: "Useless", unit_price: 50)
    @spinner = @merchant_2.items.create!(name: "Fidget Spinner", description: "Spins", unit_price: 1)
    @bouncer = @merchant_2.items.create!(name: "Bouncy Ball", description: "bounces", unit_price: 2)

    @cust_1 = Customer.create!(first_name: "Dave", last_name: "Beckam")
    @cust_2 = Customer.create!(first_name: "Becky", last_name: "Beckam")

    @invoice_1 = @cust_1.invoices.create!(status: 1)
    InvoiceItem.create!(item_id: @spinner.id, invoice_id: @invoice_1.id)
    @invoice_2 = @cust_2.invoices.create!(status: 1)
    InvoiceItem.create!(item_id: @bouncer.id, invoice_id: @invoice_2.id)
  end
  describe "As a visitor" do
    describe "When I visit /merchants/:merchant_id/invoices" do
      it "I see all of the invoices that include at least one of my merchants items
      for each invoice I also see it's ID, and each ID links to the invoice show page" do

        visit "/merchants/#{@merchant_2.id}/invoices"
        save_and_open_page

        within(".invoice_list") do
          expect(page).to have_content(@invoice_1.id)
          expect(page).to have_content(@invoice_1.status)
          expect(page).to have_content(@invoice_1.date_conversion)
          expect(page).to have_content("#{@cust_1.first_name} #{@cust_1.last_name}")
        end
      end
    end
  end
end