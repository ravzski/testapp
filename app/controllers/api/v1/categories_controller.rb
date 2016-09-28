class Api::V1::CategoriesController < ApiController

  skip_before_action :authenticate_request

  def index
    render json: Category.all
  end

  def create
    @obj = Category.new(obj_params)
    if @obj.save
      render json: @obj
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  def update
    @obj = Category.find(params[:id])
    if @obj.update_attributes(obj_params)
      render json: @obj
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  def destroy
    @obj = Category.find(params[:id])
    if @obj.destroy
      render json: {success: true}
    else
      render json: @obj.errors.full_messages, status: 422
    end
  end

  private

  def obj_params
    params.require(:category).permit(*%i(
      name
    ))
  end


end
