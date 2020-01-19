module OrdersHelper
  def deliver_status key
    Order.deliver_statuses.key Order.deliver_statuses[key]
  end
end
