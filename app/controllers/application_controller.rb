class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :load_parent_category
  protect_from_forgery with: :exception
  include CartsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to main_app.root_url
  end

  private

  def is_admin?
    return if current_user.admin?
    flash[:danger] = t "user_not_admin"
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_product
    return if @product = Product.find_by(id: params[:id])
    flash[:danger] = t "not_found_product"
    redirect_to root_url
  end

  def load_parent_category
    return if @parent_category = Category.parent_category
    flash[:danger] = t "not_found_cate"
    redirect_to root_url
  end
end
