class Api::V1::ProductsController < Api::V1::ApiController
  def index
    render json: Product.available
  end

  def show
    @product = Product.find(params[:id])
    render json: @product if @product
  end

  def create
    @product = Product.new(product_params)
    render json: @product, status: :created if @product.save!

  rescue ActiveRecord::RecordInvalid
    render json: @product.errors.full_messages, status: :unprocessable_entity
  rescue ActionController::ParameterMissing
    render json: 'Parâmetros inválidos', status: :precondition_failed
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category,
                                    :profile_id)
  end
end