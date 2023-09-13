require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin" do
      it "Then I see a header indicating that I am on the admin dashboard" do
        visit "/admin"

        within("#header") do 
          expect(page).to have_content("Admin Dashboard")
        end
      end
      
      it "Then I see links to '/admin/merchants' and '/admin/invoices'" do
        merchant = create(:merchant) 
        expect(merchant.valid?).to be true
        visit "/admin"
        
        click_on "Admin Merchants Index"

        expect(current_path).to eq("/admin/merchants")

        visit "/admin"

        click_on "Admin Invoices Index"

        expect(current_path).to eq("/admin/invoices")
      end

      it "Then I see the names of the top 5 customers who have conducted the largest number of successful transactions, next to each customer I see the number of successful transactions" do
        customer1 = Customer.create!(first_name: "Customer 1" , last_name: "Last")
        customer2 = Customer.create!(first_name: "Customer 2" , last_name: "Last")
        customer3 = Customer.create!(first_name: "Customer 3" , last_name: "Last")
        customer4 = Customer.create!(first_name: "Customer 4" , last_name: "Last")
        customer5 = Customer.create!(first_name: "Customer 5" , last_name: "Last")
        customer6 = Customer.create!(first_name: "Customer 6" , last_name: "Last")

        customer1.invoices.create!(status: 1).transactions.create!(result: 1)
        customer1.invoices.create!(status: 1).transactions.create!(result: 1)
        customer1.invoices.create!(status: 1).transactions.create!(result: 1)
        customer1.invoices.create!(status: 1).transactions.create!(result: 1)
        customer1.invoices.create!(status: 1).transactions.create!(result: 1)
        customer1.invoices.create!(status: 1).transactions.create!(result: 0)
        customer2.invoices.create!(status: 1).transactions.create!(result: 1)
        customer2.invoices.create!(status: 1).transactions.create!(result: 1)
        customer2.invoices.create!(status: 1).transactions.create!(result: 1)
        customer2.invoices.create!(status: 1).transactions.create!(result: 1)
        customer2.invoices.create!(status: 1).transactions.create!(result: 0)
        customer2.invoices.create!(status: 1).transactions.create!(result: 0)
        customer3.invoices.create!(status: 1).transactions.create!(result: 1)
        customer3.invoices.create!(status: 1).transactions.create!(result: 1)
        customer3.invoices.create!(status: 1).transactions.create!(result: 1)
        customer3.invoices.create!(status: 1).transactions.create!(result: 0)
        customer3.invoices.create!(status: 1).transactions.create!(result: 0)
        customer3.invoices.create!(status: 1).transactions.create!(result: 0)
        customer4.invoices.create!(status: 1).transactions.create!(result: 1)
        customer4.invoices.create!(status: 1).transactions.create!(result: 1)
        customer4.invoices.create!(status: 1).transactions.create!(result: 0)
        customer4.invoices.create!(status: 1).transactions.create!(result: 0)
        customer4.invoices.create!(status: 1).transactions.create!(result: 0)
        customer4.invoices.create!(status: 1).transactions.create!(result: 0)
        customer5.invoices.create!(status: 1).transactions.create!(result: 1)
        customer5.invoices.create!(status: 1).transactions.create!(result: 0)
        customer5.invoices.create!(status: 1).transactions.create!(result: 0)
        customer5.invoices.create!(status: 1).transactions.create!(result: 0)
        customer5.invoices.create!(status: 1).transactions.create!(result: 0)
        customer5.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)
        customer6.invoices.create!(status: 1).transactions.create!(result: 0)

        visit "/admin"

        within("#customer-#{customer1.id}") do
          expect(page).to have_content(customer1.first_name)
          expect(page).to have_content(customer1.last_name)
          expect(page).to have_content(5)
        end

        within("#customer-#{customer2.id}") do
          expect(page).to have_content(customer2.first_name)
          expect(page).to have_content(customer2.last_name)
          expect(page).to have_content(4)
        end

        within("#customer-#{customer3.id}") do
          expect(page).to have_content(customer3.first_name)
          expect(page).to have_content(customer3.last_name)
          expect(page).to have_content(3)
        end

        within("#customer-#{customer4.id}") do
          expect(page).to have_content(customer4.first_name)
          expect(page).to have_content(customer4.last_name)
          expect(page).to have_content(2)
        end

        within("#customer-#{customer5.id}") do
          expect(page).to have_content(customer5.first_name)
          expect(page).to have_content(customer5.last_name)
          expect(page).to have_content(1)
        end
      end
    end
  end
end