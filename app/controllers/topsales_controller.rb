class TopsalesController < ApplicationController
  def index
    @top = Product.top_sale
  end
end
