# Agora order possui um voucher
class Voucher
  # ...
end

class Order
  # ...
  belongs_to :voucher

  1. Como saber o preço total?
  2. Como saber o preço com desconto?
  
  def set_total_price
    self.total_price = line_items.map{ |line_item|  line_item.total_price }.reduce(&:+)
    # verificar desconto
    # aplicar...
  end
end
