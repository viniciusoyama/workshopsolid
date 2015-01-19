# Does not conform to SRP
class Order
  # ...
  field :service,                       type: Symbol
  field :status,                        type: Symbol, default: :waiting_for_services_and_pets
  field :total_price,                   type: Float, default: 0
  # ...


  # Associations
  # ...
  has_many :line_items
  has_many :payments

  # Scopes
  scope :by_id, -> id {where(:id => id)}
  scope :by_client, -> client_id { where(:client_id => client_id) }
  # ...

  # ...
  before_save :set_total_price
  
  def expired?
    self.status == :expired
  end

  def cancel!
    self.status = :canceled
    self.save!
  end

  def set_total_price
    self.total_price = line_items.map{ |line_item|  line_item.total_price }.reduce(&:+)
  end
end
