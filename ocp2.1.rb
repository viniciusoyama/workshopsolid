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
