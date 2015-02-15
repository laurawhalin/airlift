class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.find_by(slug: params[:slug])
		@listings = @supplier.listings.all
  end
end
