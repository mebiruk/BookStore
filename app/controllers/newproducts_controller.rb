class NewproductsController < ApplicationController
  def index
    @products = Product.create_desc.page(params[:page]).per Settings.paginate
  end
end
