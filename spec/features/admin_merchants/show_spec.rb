require 'rails_helper'

RSpec.describe "admin merchant show", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin/merchants/:merchant_id show page" do
      it "Then I see a link to update the merchant's information." do
        @merchant1 = create(:merchant)
          
        visit "/admin/merchants/#{@merchant1.id}"
          
        within("#merchant-show-#{@merchant1.id}") do 
          expect(page).to have_link("Update #{@merchant1.name}'s Information")       
        end

        click_on "Update #{@merchant1.name}'s Information"

        expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
      end
    end
  end
end