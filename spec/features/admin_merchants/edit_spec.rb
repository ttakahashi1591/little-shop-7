require 'rails_helper'

RSpec.describe "admin merchant edit form", type: :feature do
  describe "As an admin" do
    describe "When I visit /admin/merchants/:id/edit" do 
      it "Then I am taken to a page to edit this merchant and I see a form filled in with the existing merchant attribute information, then I am redirected back /admin/merchants show page where I see the updated information and I see a flash message stating that the information has been successfully updated" do
        merchant1 = create(:merchant)
        
        visit "/admin/merchants/#{merchant1.id}/edit"

        expect(find_field("name").value).to eq(merchant1.name)

        fill_in "name", with: "New Merchant Name"
        
        click_on "Submit"

        expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
        expect(page).to have_content("New Merchant Name")          
        expect(page).to have_content("Successfully Updated!")
      end
    end
  end
end