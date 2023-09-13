require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:items).through(:invoices) }
  it { should have_many(:merchants).through(:items) }

  describe "class methods" do
    describe "#top" do
      it "returns the top 5 customers based on successful transactions" do
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

        expect(Customer.top).to eq([customer1, customer2, customer3, customer4, customer5])
      end
    end
  end
end