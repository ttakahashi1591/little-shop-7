require 'rails_helper'

RSpec.describe "the admin_merchants new page", type: :feature do
  describe "As an admin" do
    describe "When I visit /admin/merchants/new" do
      it "I fill out the form and click submit" do
        visit "/admin/merchants/new"

        fill_in "Name", with: "Newest Merchant"
        click_button "Submit"

        expect(current_path).to eq("/admin/merchants")
        expect(page).to have_content("Newest Merchant")
      end
    end
  end
end