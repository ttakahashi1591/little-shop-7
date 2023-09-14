require "rails_helper"

RSpec.describe "the admin_invoices id show page", type: :feature do
  describe "As an admin" do
    describe "When I visit '/admin/invoices/:invoice_id" do
      it "Then I see information related to that invoice: id, status, created_at, Customer first and last name" do
        merchant1 = Merchant.create!(name: "Merchant")
        item1 = merchant1.items.create!(name: "Item 1", description: "First Item", unit_price: 10)
        item2 = merchant1.items.create!(name: "Item 1", description: "Second Item", unit_price: 20)
        item3 = merchant1.items.create!(name: "Item 1", description: "Third Item", unit_price: 30)
        customer1 = Customer.create!(first_name: "John" , last_name: "Smith")
        invoice1 = customer1.invoices.create!(status: 1)
        invoice2 = customer1.invoices.create!(status: 1)
        invoice3 = customer1.invoices.create!(status: 1)
        InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, status: 2)
        InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, status: 1)
        InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, status: 1)
        
        visit "/admin/invoices/#{invoice1.id}"

        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice1.status)
        expect(page).to have_content(invoice1.date_conversion)
        expect(page).to have_content(customer1.first_name)
        expect(page).to have_content(customer1.last_name)
      end
    end
  end
end
