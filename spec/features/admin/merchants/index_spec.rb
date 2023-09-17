require 'rails_helper'

RSpec.describe "admin dashboard", type: :feature do 
  describe "As an admin" do
    describe "When I visit /admin/merchants index" do
      it "Then I see the name of each merchant in the system" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
        merchant4 = create(:merchant)
        merchant5 = create(:merchant)

        visit "/admin/merchants"

        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
        end

        within("#merchant-index-#{merchant2.id}") do 
          expect(page).to have_content(merchant2.name)
        end

        within("#merchant-index-#{merchant3.id}") do 
          expect(page).to have_content(merchant3.name)
        end
          
        within("#merchant-index-#{merchant4.id}") do 
          expect(page).to have_content(merchant4.name)
        end

        within("#merchant-index-#{merchant5.id}") do
          expect(page).to have_content(merchant5.name)
        end
      end

      it "Then I see the names of the top 5 merchants by total revenue generated, and each name is a link to the admin merchant page, the total revenue generated is next to each merchant" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
        merchant4 = create(:merchant)
        merchant5 = create(:merchant)
        merchant6 = create(:merchant)
        item1 = create(:item, unit_price: 100, merchant_id: merchant1.id)
        item2 = create(:item, unit_price: 100, merchant_id: merchant2.id)
        item3 = create(:item, unit_price: 100, merchant_id: merchant3.id)
        item4 = create(:item, unit_price: 100, merchant_id: merchant4.id)
        item5 = create(:item, unit_price: 100, merchant_id: merchant5.id)
        item6 = create(:item, unit_price: 100, merchant_id: merchant6.id)
        customer = Customer.create!(first_name: "John", last_name: "Smith")
        invoice1 = customer.invoices.create!(status: 1)
        invoice2 = customer.invoices.create!(status: 1)
        invoice3 = customer.invoices.create!(status: 1)
        invoice4 = customer.invoices.create!(status: 1)
        invoice5 = customer.invoices.create!(status: 1)
        invoice6 = customer.invoices.create!(status: 1)
        InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 3, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 5, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 2, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 6, unit_price: 100, status: 2)
        InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 100, status: 2)
        invoice1.transactions.create!(result: 1)
        invoice2.transactions.create!(result: 0)
        invoice3.transactions.create!(result: 0)
        invoice3.transactions.create!(result: 1)
        invoice4.transactions.create!(result: 1)
        invoice5.transactions.create!(result: 1)
        invoice6.transactions.create!(result: 1)

        visit "/admin/merchants"

        within("#top_5-#{merchant1.id}") do
          expect(page).to have_content(merchant1.name)
          expect(page).to have_link(merchant1.name, href: admin_merchant_path(merchant1))
          expect(page).to have_content(merchant1.total_revenue)
        end

        within("#top_5-#{merchant3.id}") do
          expect(page).to have_content(merchant3.name)
          expect(page).to have_link(merchant3.name, href: admin_merchant_path(merchant3))
          expect(page).to have_content(merchant3.total_revenue)
        end

        within("#top_5-#{merchant4.id}") do
          expect(page).to have_content(merchant4.name)
          expect(page).to have_link(merchant4.name, href: admin_merchant_path(merchant4))
          expect(page).to have_content(merchant4.total_revenue)
        end

        within("#top_5-#{merchant5.id}") do
          expect(page).to have_content(merchant5.name)
          expect(page).to have_link(merchant5.name, href: admin_merchant_path(merchant5))
          expect(page).to have_content(merchant5.total_revenue)
        end

        within("#top_5-#{merchant6.id}") do
          expect(page).to have_content(merchant6.name)
          expect(page).to have_link(merchant6.name, href: admin_merchant_path(merchant6))
          expect(page).to have_content(merchant6.total_revenue)
        end

        expect(merchant3.name).to appear_before(merchant5.name)
        expect(merchant5.name).to appear_before(merchant1.name)
        expect(merchant1.name).to appear_before(merchant6.name)
        expect(merchant6.name).to appear_before(merchant4.name)
      end

      it "Then I see a link to create a new merchant, when I click on the link I am taken to a form" do
        visit "/admin/merchants"

        click_on "Create New Merchant"

        expect(current_path).to eq("/admin/merchants/new")
      end
    end
    
    describe "When I click on the name of a merchant from the /admin/merchants index page" do
      it "Then I am taken to that /admin/merchants/:merchant_id show page and I see the name of that merchant" do
        merchant1 = create(:merchant)
        merchant3 = create(:merchant)
        merchant2 = create(:merchant)

        visit "/admin/merchants"
      
        within("#merchant-index-#{merchant1.id}") do 
          expect(page).to have_content(merchant1.name)
      
          click_on "#{merchant1.name}"
      
          expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
        end
        
        visit "/admin/merchants"

        within("#merchant-index-#{merchant2.id}") do
          expect(page).to have_content(merchant2.name)

          click_on "#{merchant2.name}"

          expect(current_path).to eq("/admin/merchants/#{merchant2.id}")
        end


        visit "/admin/merchants"

        within("#merchant-index-#{merchant3.id}") do
          expect(page).to have_content(merchant3.name)

          click_on "#{merchant3.name}"

          expect(current_path).to eq("/admin/merchants/#{merchant3.id}")
        end
      end
    end
  end
end