require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin/merchants index" do
      it "Then I see the name of each merchant in the system" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
        merchant4 = create(:merchant)
        merchant5 = create(:merchant)

        visit "/admin/merchants"

        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
        end

        within("#merchant-index-#{merchant2.id}") do 
          expect(page).to have_content(merchant2.name)
        end

        within("#merchant-index-#{merchant3.id}") do 
          expect(page).to have_content(merchant3.name)
        end
          
        within("#merchant-index-#{merchant4.id}") do 
          expect(page).to have_content(merchant4.name)
        end

        within("#merchant-index-#{merchant5.id}") do
          expect(page).to have_content(merchant5.name)
        end
      end
    end
    
    describe "When I click on the name of a merchant from the /admin/merchants index page" do
      it "Then I am taken to that /admin/merchants/:merchant_id show page and I see the name of that merchant" do
        merchant1 = create(:merchant)
        merchant3 = create(:merchant)
        merchant2 = create(:merchant)

        visit "/admin/merchants"
      
        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
      
          click_on "#{merchant1.name}"
      
          expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
        end
        
        visit "/admin/merchants"

        within("#merchant-index-#{merchant2.id}") do
          expect(page).to have_content(merchant2.name)

          click_on "#{merchant2.name}"

          expect(current_path).to eq("/admin/merchants/#{merchant2.id}")
        end

        visit "/admin/merchants"

        within("#merchant-index-#{merchant3.id}") do
          expect(page).to have_content(merchant3.name)

          click_on "#{merchant3.name}"

          expect(current_path).to eq("/admin/merchants/#{merchant3.id}")
        end
      end
    end

    describe "When I visit the /admin/merchants index page" do
      it "Then next to each merchant name I see a button to disable or enable that merchant and then I am redirected back to the admin merchants index where I see that the merchant's status has changed." do
        merchant1 = create(:merchant)
  
        visit "/admin/merchants"

        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
          expect(page).to have_button("Disable")
        end

        click_button "Disable"

        expect(current_path).to eq("/admin/merchants")
        expect(page).to have_content("Merchant is now disabled.")

        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
          expect(page).to have_button("Enable")
        end

        click_button "Enable"

        expect(current_path).to eq("/admin/merchants")
        expect(page).to have_content("Merchant is now enabled.") 
      end
    end
  end
end