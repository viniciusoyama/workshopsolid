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

# Usage
DeliverPackages.on(visit)
  .deliver_by!(driver, visit_date)
  .notify_via(VisitMailer)

# If the rules change and want to notify via sms

class SMSNotifier
  def send_message(number, message)
    # post to SMS service...
  end

  def delivered(visit)
    send_message(visit.user.phone_number, "Good news: your package has been delivered.")
  end
end


DeliverPackages.on(visit)
  .deliver_by!(driver, visit_date)
  .notify_via(VisitMailer)
  .notify_via(SMSNotifier)
