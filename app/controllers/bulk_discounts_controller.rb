class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
  end
end