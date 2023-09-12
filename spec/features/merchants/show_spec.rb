require 'rails_helper'

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Geoff's Goodies")
  end
  describe "As a merchant" do
    describe "When i viist my dashboard (/merchants/:merchant_id/dashboard)" do
      it "Then i see the name of my merchant" do

        visit "/merchants/#{@merchant_1.id}/dashboard"

        within(".merchant_header") do
          expect(page).to have_content(@merchant_1.name)
        end
      end

      it "I also see a link to my items index /merchants/:id/items" do

        visit "merchants/#{@merchant_1.id}/dashboard"

        within('.merchant_links') do
          expect(page).to have_link "Your Items", href: "/merchants/#{@merchant_1.id}/items"
        end
      end

      it "I also see a link to my invoices index /merchants/:id/invoices" do

        visit "merchants/#{@merchant_1.id}/dashboard"

        within('.merchant_links') do
          expect(page).to have_link "Your Invoices", href: "/merchants/#{@merchant_1.id}/invoices"
        end
      end
    end
  end
end