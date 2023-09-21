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
    end
  end
end