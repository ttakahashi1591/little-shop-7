require 'rails_helper'

RSpec.describe "Merchant Items Show Page", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @merchant_2 = create(:merchant)
    @items_2 = create_list(:item, 3, merchant: @merchant_2)
  end
end