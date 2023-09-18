require "rails_helper"

RSpec.describe "the admin_invoice index page", type: :feature do
  describe "As an admin" do
    describe "When I visit '/admin/invoices'" do
      it "Then I see a list of all Invoice ids in the system, each id links to the admin invoice show page" do
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
        
        visit "/admin/invoices"

        within("#invoice-#{invoice1.id}") do
          expect(page).to have_content(invoice1.id)

          click_on "#{invoice1.id}"

          expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
        end

        visit "/admin/invoices"

        within("#invoice-#{invoice2.id}") do
          expect(page).to have_content(invoice2.id)

          click_on "#{invoice2.id}"

          expect(current_path).to eq("/admin/invoices/#{invoice2.id}")
        end

        visit "/admin/invoices"

        within("#invoice-#{invoice3.id}") do
          expect(page).to have_content(invoice3.id)

          click_on "#{invoice3.id}"

          expect(current_path).to eq("/admin/invoices/#{invoice3.id}")
        end
      end
    end
  end
end