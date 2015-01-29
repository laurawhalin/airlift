module AdminOrdersHelper
  def change_status
    @order = Order.find(params[:id])
    if params[:commit] == "cancel"
      @order.update(status: "cancelled")
      redirect_to admin_orders_path
    elsif params[:commit] == "mark as paid"
      @order.update(status: "paid")
      redirect_to admin_orders_path
    elsif params[:commit] == "mark as completed"
      @order.update(status: "completed")
      redirect_to admin_orders_path
    end
  end  
end
