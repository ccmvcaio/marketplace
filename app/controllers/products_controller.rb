class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index   
    @products = Product.all
  end
end