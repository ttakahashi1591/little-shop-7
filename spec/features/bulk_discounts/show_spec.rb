require 'rails_helper'

RSpec.describe "Bulk Discounts index page", type: :feature do
  before(:each) do
    load_test_data
  end
  describe "As a visitor" do
    describe "When I visit /merchants/:merchant_id/bulk_discounts/:bulk_discount_id" do
      it "Then I see the bulk discount's quantity threshold and percentage discount" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@discount_1.id}"

        expect(page).to have_content("Threshold: #{@discount_1.threshold}")
        expect(page).to have_content("Discount: #{@discount_1.discount}")
      end

      it "Then I see a link to edit the bulk discount
      When I click this link
      Then I am taken to a new page with a form to edit the discount
      And I see that the discounts current attributes are pre-poluated in the form
      When I change any/all of the information and click submit
      Then I am redirected to the bulk discount's show page
      And I see that the discount's attributes have been updated" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@discount_1.id}"

        click_on "Edit"

        expect(page).to have_content("Threshold: #{@discount_1.threshold}")
        expect(page).to have_content("Discount: #{@discount_1.discount}")

        fill_in :threshold, with: "2"
        fill_in :discount, with: "5"
        click_on "Submit"

        within(".discount_id_#{@discount_1.id}") do
          expect(page).to have_content("Threshold: 2")
          expect(page).to have_content("Discount: 5")
        end
      end
    end
  end
end