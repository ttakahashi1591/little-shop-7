require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin" do
      it "Then I see a header indicating that I am on the admin dashboard" do
        visit "/admin"

        within("#header") do 
          expect(page).to have_content("Admin Dashboard")
          save_and_open_page
        end
      end
    end
  end
end