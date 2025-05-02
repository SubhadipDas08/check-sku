class OrdersController < ApplicationController
  def index
    @order = Order.includes(:line_items).find_by(external_id: order_params[:external_id])
    if @order.presence
      if (@order.locked_at && @order.locked_at < (DateTime.now - 15.minutes))
        render status: 422, message: 'LockedForEdit'
      else
        @order.line_items.update(original: true)
        render json: 'Line Items Updated'
      end
    else
      render json: 'Order not found'
    end
  end

  def lock
    @order = Order.find_by(external_id: order_params[:id])

    if @order
      @order.update(locked_at: DateTime.now())
      render status: 200, message: 'Enqueued background SKU calculation task'
    else
      render status: 422, message: 'unprocessable entity'
    end
  end

  private
  def order_params
    params.permit(:id, :external_id, :placed_at, line_items:[:sku, :quantity])
  end
end
