require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin" do
      it "Then I see a header indicating that I am on the admin dashboard" do
        visit "/admin"

        within("#header") do 
          expect(page).to have_content("Admin Dashboard")
        end
      end
      
      it "Then I see links to '/admin/merchants' and '/admin/invoices'" do
        merchant = create(:merchant) 
        expect(merchant.valid?).to be true
        visit "/admin"
        
        save_and_open_page
        click_on "Admin Merchants Index"

        expect(current_path).to eq("/admin/merchants")

        visit "/admin"

        click_on "Admin Invoices Index"

        expect(current_path).to eq("/admin/invoices")
      end
    end
  end
end