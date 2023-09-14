require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin/merchants" do
      it "Then I see the name of each merchant in the system" do
        @merchant1 = create(:merchant)
        @merchant2 = create(:merchant)
        @merchant3 = create(:merchant)
        @merchant4 = create(:merchant)
        @merchant5 = create(:merchant)

        visit "/admin/merchants"

        within("#merchant-index-#{@merchant1.id}") do 
          expect(page).to have_content(@merchant1.name)
        end

        within("#merchant-index-#{@merchant2.id}") do 
          expect(page).to have_content(@merchant2.name)
        end

        within("#merchant-index-#{@merchant3.id}") do 
          expect(page).to have_content(@merchant3.name)
        end
          
        within("#merchant-index-#{@merchant4.id}") do 
          expect(page).to have_content(@merchant4.name)
        end

        within("#merchant-index-#{@merchant5.id}") do
          expect(page).to have_content(@merchant5.name)
        end
      end
    end
  end
end