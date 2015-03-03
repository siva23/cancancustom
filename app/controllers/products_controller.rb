class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
    authorize! :read, @product
  end

  def new
    @product = Product.new
    respond_with(@product)
    authorize! :create, @product
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    authorize! :create, @product
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
