# encoding: utf-8

class DeliverPackages
  attr_reader :visit

  def initialize(visit)
    @visit = visit
  end

  def deliver_by!(driver, visit_date = Date.current)
    visit.visited_by!(driver, on: visit_date)
  end

  def notify_via(notifier)    
    notifier.delivered(visit.id)
  end

  def self.on(visit)
    new(visit)
  end
end
