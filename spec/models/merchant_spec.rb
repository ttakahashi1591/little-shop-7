require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dude")
    chochky = @merchant_1.items.create!(name: "chochky", description: "Useless", unit_price: 50)
    @cust_1 = Customer.create!(first_name: "Dave", last_name: "Beckam")
    @cust_1.invoices.create!(status: 1)
    @cust_1.invoices.create!(status: 1)
    @cust_1.invoices.create!(status: 1)
    @cust_1.invoices.create!(status: 1)
    @cust_1.invoices.create!(status: 1)
    @cust_2 = Customer.create!(first_name: "Bryan", last_name: "Beckam")
    @cust_3 = Customer.create!(first_name: "Dorry", last_name: "Beckam")
    @cust_4 = Customer.create!(first_name: "Lily", last_name: "Beckam")
    @cust_5 = Customer.create!(first_name: "Sheryl", last_name: "Beckam")
    @cust_6 = Customer.create!(first_name: "Archer", last_name: "Beckam")
  end
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end
end