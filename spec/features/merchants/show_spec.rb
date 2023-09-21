require 'rails_helper'

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    load_test_data

    5.times { @cust_1
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    4.times { @cust_3
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    3.times { @cust_2
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    2.times { @cust_5
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @chochky.id)
              .invoice.transactions.create!(result: 1)
            } 

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @spinner.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_6
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @spinner.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_6
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 1, quantity: 1, unit_price: 1, item_id: @bouncer.id)
              .invoice.transactions.create!(result: 1)
            }
  end
  describe "As a merchant" do
    describe "When i viist my dashboard (/merchants/:merchant_id/dashboard)" do
      it "Then i see the name of my merchant" do

        visit "/merchants/#{@merchant_1.id}/dashboard"

        within(".merchant_header") do
          expect(page).to have_content(@merchant_1.name)
        end
      end

      it "I also see a link to my items index /merchants/:id/items" do

        visit "/merchants/#{@merchant_1.id}/dashboard"

        within('.merchant_links') do
          expect(page).to have_link "Your Items", href: "/merchants/#{@merchant_1.id}/items"
        end
      end

      it "I also see a link to my invoices index /merchants/:id/invoices" do

        visit "/merchants/#{@merchant_1.id}/dashboard"

        within('.merchant_links') do
          expect(page).to have_link "Your Invoices", href: "/merchants/#{@merchant_1.id}/invoices"
        end
      end

      it "I also see a link to my bulk discounts page" do

        visit "/merchants/#{@merchant_1.id}/dashboard"

        within('.merchant_links') do
          expect(page).to have_link "Bulk Discounts", href: "/merchants/#{@merchant_1.id}/bulk_discounts"
        end
      end

      it "I see a section with my top 5 customers with most successful transactions" do
         
        visit "/merchants/#{@merchant_1.id}/dashboard"

        within(".fav_customers") do
          expect(@cust_1.first_name).to appear_before(@cust_3.first_name)
          expect(@cust_3.first_name).to appear_before(@cust_2.first_name)
          expect(@cust_2.first_name).to appear_before(@cust_5.first_name)
          expect(@cust_5.first_name).to appear_before(@cust_4.first_name)
        end

        within(".#{@cust_1.first_name}") do
          expect(page).to have_content("Successful Transactions: 5")
        end
        within(".#{@cust_3.first_name}") do
          expect(page).to have_content("Successful Transactions: 4")
        end
        within(".#{@cust_2.first_name}") do
          expect(page).to have_content("Successful Transactions: 3")
        end
        within(".#{@cust_5.first_name}") do
          expect(page).to have_content("Successful Transactions: 2")
        end
        within(".#{@cust_4.first_name}") do
          expect(page).to have_content("Successful Transactions: 1")
        end
      end

      it "I see a list of items ready to ship" do

        visit "/merchants/#{@merchant_2.id}/dashboard"

        within(".items_ready_to_ship") do
          expect(page).to have_content("#{@bouncer.name}")
          expect(page).to have_link href: "/merchants/#{@merchant_2.id}/invoices/#{@bouncer.invoices.first.id}"
        end
      end

      it "In the section for items ready to ship, 
      I see them ordered by oldest created to most recent formated (Day_name, Month day_number, year)" do

        ordered_invoices = @merchant_2.invoices.order('created_at')

        visit "merchants/#{@merchant_2.id}/dashboard"

        invoice_1_index = page.body.index("invoices/#{ordered_invoices[0].id.to_s}")
        invoice_2_index = page.body.index("invoices/#{ordered_invoices[1].id.to_s}")
        invoice_3_index = page.body.index("invoices/#{ordered_invoices[2].id.to_s}")

        expect(invoice_1_index.to_i < invoice_2_index.to_i).to be_truthy
        expect(invoice_2_index.to_i < invoice_3_index.to_i).to be_truthy
      end
    end
  end
end