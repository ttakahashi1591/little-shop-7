require 'rails_helper'

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Geoff's Goodies")
    @merchant_2 = Merchant.create!(name: "Bubba's Boutique")
    chochky = @merchant_1.items.create!(name: "chochky", description: "Useless", unit_price: 50)
    spinner = @merchant_2.items.create!(name: "Fidget Spinner", description: "Spins", unit_price: 1)

    @cust_1 = Customer.create!(first_name: "Dave", last_name: "Beckam")
    @cust_2 = Customer.create!(first_name: "Becky", last_name: "Beckam")
    @cust_3 = Customer.create!(first_name: "Steve", last_name: "Beckam")
    @cust_4 = Customer.create!(first_name: "Roger", last_name: "Beckam")
    @cust_5 = Customer.create!(first_name: "Winnona", last_name: "Beckam")
    @cust_6 = Customer.create!(first_name: "Bend_it", last_name: "Beckam")
    5.times { @cust_1
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    4.times { @cust_3
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    3.times { @cust_2
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    2.times { @cust_5
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 1)
            }

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 1)
            } 

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: chochky.id)
              .invoice.transactions.create!(result: 0)
            } 

    1.times { @cust_4
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: spinner.id)
              .invoice.transactions.create!(result: 0)
            }

    1.times { @cust_6
              .invoices.create!(status: 1)
              .invoice_items.create!(status: 2, quantity: 1, unit_price: 1, item_id: spinner.id)
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

      it "I see a section with my top 5 customers with most successful transactions" do
         
        visit "/merchants/#{@merchant_1.id}/dashboard"

        # within(".fav_customers") do
        #   expect(@cust_1.first_name).to appear_before(@cust_3.first_name)
        #   expect(@cust_3.first_name).to appear_before(@cust_2.first_name)
        #   expect(@cust_2.first_name).to appear_before(@cust_5.first_name)
        #   expect(@cust_5.first_name).to appear_before(@cust_4.first_name)
        # end

        save_and_open_page

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
    end
  end
end