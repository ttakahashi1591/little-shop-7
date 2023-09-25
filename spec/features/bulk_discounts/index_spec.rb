require 'rails_helper'

RSpec.describe "Bulk Discounts index page", type: :feature do
  before(:each) do
    load_test_data
  end
  describe "As a visitor" do
    describe "When I visit /merchants/:merchant_id/bulk_discounts" do
      it "I see all of my bulk discounts including their
      percentage discount and quantity thresholds" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        within(".discount_id_#{@discount_1.id}") do
          expect(page).to have_content("Threshold: #{@discount_1.threshold}")
          expect(page).to have_content("Discount: #{@discount_1.discount}%")
          expect(page).to have_link "#{@discount_1.id}", href: "#{merchant_bulk_discount_path(@merchant1, @discount_1)}"
        end

        within(".discount_id_#{@discount_2.id}") do
          expect(page).to have_content("Threshold: #{@discount_2.threshold}")
          expect(page).to have_content("Discount: #{@discount_2.discount}%")
          expect(page).to have_link "#{@discount_2.id}", href: "#{merchant_bulk_discount_path(@merchant1, @discount_2)}"
        end
      end

      it "And each bulk discount listed includes a link to its show page" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        within(".discount_id_#{@discount_1.id}") do
          expect(page).to have_link "#{@discount_1.id}", href: "#{merchant_bulk_discount_path(@merchant1, @discount_1)}"
        end

        within(".discount_id_#{@discount_2.id}") do
          expect(page)
        end
      end

      it "Then I see a link to create a new discount
      When I click this link
      Then I am taken to a new page where I see a form to add a new bulk discount
      When I fill in the form with valid data
      Then I am redirected back to the bulk discount index
      And I see my new bulk discount listed" do
        
        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        click_on "Create New Discount"

        fill_in "Threshold", with: "35"
        fill_in "Discount", with: "32"
        click_on "Submit"

        expect(page).to have_content("Threshold: 35")
        expect(page).to have_content("Discount: 32")
      end

      it "I see a button to Delete next to each bulk discount
      When I click this button
      Then I am redirected back to the bulk discounts index page
      And I no longer see the discount listed" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        within(".discount_id_#{@discount_1.id}") do
          click_on "Delete"
        end

        expect(page).to_not have_content("Threshold: #{@discount_1.threshold}")
        expect(page).to_not have_content("Discount: #{@discount_1.discount}")
      end

      it "I can only delete a bulk discount if there are no pending invoices that qualify for said discount" do

        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        within(".discount_id_#{@discount_3.id}") do
          click_on "Delete"
        end

        expect(page).to have_content("Error: this discount can't be modified or deleted while there are pending invoices")
      end
    end
  end
end