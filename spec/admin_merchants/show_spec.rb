require 'rails_helper'

RSpec.describe "admin merchant show", type: :feature do 
  describe "As an admin" do
    describe "When I click on the name of a merchant from the /admin/merchants index page" do
      it "Then I am taken to that /admin/merchants/:merchant_id show page and I see the name of that merchant" do
        @merchant1 = create(:merchant)
        
        visit "/admin/merchants"
        
        within("#merchant-index-#{@merchant1.id}") do 
          expect(page).to have_content(@merchant1.name)
        
          click_on "#{@merchant1.name}"
        
          expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
        end
      
        @merchant2 = create(:merchant)
      
        visit "/admin/merchants"

        within("#merchant-index-#{@merchant2.id}") do
          expect(page).to have_content(@merchant2.name)

          click_on "#{@merchant2.name}"

          expect(current_path).to eq("/admin/merchants/#{@merchant2.id}")
        end

        @merchant3 = create(:merchant)

        visit "/admin/merchants"

        within("#merchant-index-#{@merchant3.id}") do
          expect(page).to have_content(@merchant3.name)

          click_on "#{@merchant3.name}"

          expect(current_path).to eq("/admin/merchants/#{@merchant3.id}")
        end
      end
    end
  end
end