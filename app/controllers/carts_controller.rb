class CartsController < ApplicationController
  before_action :total_cart, only: :index
  before_action :set_cart, only: :create
  before_action :load_item, only: %i(update destroy)

  def index
    @order = current_user.orders.build if user_signed_in?
  end

  def create
    session[:cart][params[:id]] = params[:quantity].to_i
    flash[:success] = t "update_cart"
    redirect_to carts_path
  end

  def update
    session[:cart][params[:product_id]] = params[:quantity].to_i
    @total_price = total_cart
    respond_to do |f|
      f.js
    end
  end

  def destroy
    session[:cart].delete params[:id]
    @total_price = total_cart
    respond_to do |format|
      format.js
    end
  end

  private

  def set_cart
    return if session[:cart]
    session[:cart] = {}
  end

  def load_item
    id = params[:product_id] ? params[:product_id] : params[:id]
    return if session[:cart].include? id
    flash[:danger] = t "not_found_product"
    redirect_to carts_path
  end

  def total_cart
    return unless current_cart?
    @total = 0
    session[:cart].each do |key, val|
      product = find_product key
      prices = product.price * val
      @total += prices
    end
    @total
  end
end
