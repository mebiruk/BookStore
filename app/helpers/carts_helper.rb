module CartsHelper
  def find_product id
    product = Product.find_by id: id
    return Product.find_by id: id if product
    flash[:danger] = t "not_found_product"
    redirect_to root_url
  end

  def total_price price, num
    price * num
  end

  def cart_size
    session[:cart].size
  end

  def current_cart
    @curren_cart = session[:cart]
  end

  def current_cart?
    current_cart.present?
  end
end
