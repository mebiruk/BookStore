class SearchProductsController < ApplicationController
  def search
    @products = Product.search params[:search_keyword]
    respond_to(&:js) if @products
  end
end
