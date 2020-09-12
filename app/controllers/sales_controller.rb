class SalesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @products = Product.all
    @current_profile_products = set_current_profile_products(@products)
  end

  def new
    @product = Product.find(params[:product_id])
    @sale = Sale.new
  end

  def create
    @product = Product.find(params[:product_id])
    @sale = @product.build_sale(sale_params) 
    @sale.profile = current_user.profile
    if @sale.save
      @product.waiting_confirmation!
      redirect_to @product
    else
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:final_price, :product_id)
  end

  def set_current_profile_products(products)
    products.find_all {|product| product.profile == current_user.profile}
  end
end