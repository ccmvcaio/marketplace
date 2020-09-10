class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index   
    @products = Product.all
    @available_products = set_available_products(@products)
  end

  private

  def set_available_products(products)
    products.find_all {|product| product.profile.user.email_domain == current_user.email_domain}
  end
end