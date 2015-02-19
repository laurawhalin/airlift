class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
  end

  def index
  end
end
