class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :search]

  def index
    @products = Product.all
    @available_products = set_available_products(@products)
  end

  def new
     @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.profile = current_user.profile
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where("name LIKE (?)", "%#{params[:q]}%")
            .or(Product.where("category LIKE (?)", "%#{params[:q]}%")
            .or(Product.where("description LIKE (?)", "%#{params[:q]}%")))
    @available_products = set_available_products(@products)
    render :index
  end

  private

  def product_params
    params.require(:product).permit(:name, :category, :price, :description, images: [])
  end

  def set_available_products(products)
    products.find_all {|product| product.profile.enterprise_id == 
                                 current_user.profile.enterprise_id}
  end
end