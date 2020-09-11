class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.profile = current_user.profile
    @comment.send_date = Time.zone.now
    @comment.save
    redirect_to @product
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end