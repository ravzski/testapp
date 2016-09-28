class Api::V1::ProductsController < ApiController

  skip_before_action :authenticate_request

  def index
    render json: Product.order("id DESC")
  end

  def create
    @obj = Product.new(obj_params)
    if @obj.save
      render json: @obj
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  def update
    @obj = Product.find(params[:id])
    if @obj.update_attributes(obj_params)
      render json: @obj
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  def destroy
    @obj = Product.find(params[:id])
    if @obj.destroy
      render json: {success: true}
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  private

  def obj_params
    params.require(:product).permit(*%i(
      name
      price
      category_id
    ))
  end


end
