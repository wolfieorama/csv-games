class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.csv {send_data @products.to_csv, filename: "products-#{Date.today}.csv"}
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
end
