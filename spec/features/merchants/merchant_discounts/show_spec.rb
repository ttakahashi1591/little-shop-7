require 'rails_helper'

RSpec.describe "Merchant Discounts Show Page", type: :feature do
  before :each do 
    load_test_data
    @discount = @merchant.discounts.create(percent: 20, quantity_threshold: 2)
    @discount2 = @merchant.discounts.create(percent: 10, quantity_threshold: 1)
  end
end