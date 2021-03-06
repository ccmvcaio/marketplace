class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create,
                                            :edit, :update, :search, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    @same_enterprise_products = set_same_enterprise_products(@products)
    @available_products = set_available_products(@same_enterprise_products)
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
  end

  def edit
  end

  def update
    @sale = @product.sale
    if @product.update(product_params)
      if @product.canceled?
        @product.available!
        @product.sale = Sale.destroy(@sale.id)
        redirect_to @product
      elsif
        @product.sold?
        redirect_to sales_path
      else
        redirect_to @product
      end
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def search
    @products = Product.where("name LIKE (?)", "%#{params[:q]}%")
            .or(Product.where("category LIKE (?)", "%#{params[:q]}%")
            .or(Product.where("description LIKE (?)", "%#{params[:q]}%")))
    @same_enterprise_products = set_same_enterprise_products(@products)
    @available_products = set_available_products(@same_enterprise_products)
    render :index
  end

  private

  def product_params
    params.require(:product).permit(:name, :category, :price, :description,:status,
                                    :sale_id, images: [])
  end

  def set_same_enterprise_products(products)
    products.find_all {|product| product.profile.enterprise_id == 
                                 current_user.profile.enterprise_id}
  end

  def set_available_products(products)
    products.select {|product| product.available?}    
  end

  def set_product
    @product = Product.find(params[:id])
  end
end