class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.csv {send_data @products.to_csv, filename: "products-#{Date.today}.csv"}
    end
  end

  def new
    @product = Product.new(product_params)
  end

  def create
    @product = Product.new(product_params)
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
  end

  def import
    begin
      Product.import(params[:file])
      redirect_to root_url, notice: "Products imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  private

  def product_params
    params.require(:products).permit(:title, :price, :quantity)
  end
end
