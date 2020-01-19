class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def show
    @reviews = @product.reviews.create_desc
  end
end
