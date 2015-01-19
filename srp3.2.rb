# Agora order possui um voucher
class Voucher
  # ...
end

class Order
  # ...
  belongs_to :voucher

  def set_total_price
    self.total_price = price.gross
  end

  def price
    @price ||= Order::PriceCalculator.new(self)
  end
end

# Price

class Order::PriceCalculator
  include Comparable
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def gross
    @order_gross_price || calculate_order_gross_price
  end

  def net
    if @order.voucher.present?
      gross - (gross * @order.voucher.discount_in_percentage / 100)
    else
      gross
    end
  end

  def <=>(another_price)
    self.net <=> another_price.net
  end

  private

    def calculate_order_gross_price
      return 0.to_money if @order.line_items.count.zero?
      @order_gross_price = @order.line_items.map{ |line_item|  line_item.total_price }.reduce(&:+).to_money
    end
end

