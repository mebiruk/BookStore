class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart, only: :create
  before_action :load_order, :is_cancel?, only: :update

  def index
    @orders = current_user.orders.preload(order_products: :product).create_desc
  end

  def create
    @order = current_user.orders.build order_params
    if @order.save
      create_order_product
      update_product
      session[:cart].clear
      flash[:success] = t "order_success"
      redirect_to orders_path
    else
      flash[:danger] = t "order_failse"
      redirect_to carts_path
    end
  end

  def update
    @order.cancel!
    respond_to(&:js)
  rescue StandardError
    flash[:danger] = t "update_order_failed"
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def check_cart
    return unless current_cart.empty?
    flash[:danger] = t "cart_empty"
    redirect_to carts_path
  end

  def total_price key, val
    product = find_product key
    product.price * val
  end

  def create_order_product
    current_cart.each do |key, val|
      @order_product = @order.order_products.build product_id: key,
        num_product: val, price: total_price(key, val)
      unless @order_product.save
        flash[:danger] = t "order_failse"
        redirect_to carts_path
      end
    end
  end

  def update_product
    current_cart.each do |key, val|
      product = find_product key
      num = product.num_exist - val
      unless product.update num_exist: num
        flash[:danger] = t "order_failse"
        redirect_to root_url
      end
    end
  end

  def load_order
    return if @order = Order.find_by(id: params[:id])
    flash[:danger] = t "not_found_order"
    redirect_to orders_path
  end

  def is_cancel?
    return if params[:status].eql? "cancel"

    flash[:danger] = t "not_found_order"
    redirect_to orders_path
  end
end
