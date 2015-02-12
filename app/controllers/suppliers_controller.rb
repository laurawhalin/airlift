class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.find_by(slug: params[:slug])
  end
end
