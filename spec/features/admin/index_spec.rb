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

      it "Then I see a section for 'Incomplete Invoices' that lists the ids of invoices with unshipped items, each id is a link to it's admin show page" do
        merchant1 = Merchant.create!(name: "Merchant")
        item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
        item2 = merchant1.items.create!(name: "Item 1", description: "Second Item", unit_price: 20)
        item3 = merchant1.items.create!(name: "Item 1", description: "Third Item", unit_price: 30)
        customer1 = Customer.create!(first_name: "Customer 1" , last_name: "Last")
        invoice1 = customer1.invoices.create!(status: 1)
        invoice2 = customer1.invoices.create!(status: 1)
        invoice3 = customer1.invoices.create!(status: 1)
        InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, status: 2)
        InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, status: 1)
        InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, status: 1)
        
        visit "/admin"

        expect(page).to have_content("Incomplete Invoices")

        within("#invoice-#{invoice2.id}") do
          expect(page).to have_content(invoice2.id)

          click_on "#{invoice2.id}"

          expect(current_path).to eq("/admin/invoices/#{invoice2.id}")
        end

        visit "/admin"

        within("#invoice-#{invoice3.id}") do
          expect(page).to have_content(invoice3.id)

          click_on "#{invoice3.id}"

          expect(current_path).to eq("/admin/invoices/#{invoice3.id}")
        end
      end
    end
  end
end