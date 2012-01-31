module ApplicationHelper
  def expired_recurring_slips
    expired = RecurringSlip.expired
    '<span class="circle">' + expired.to_s + '</span>' if expired > 0
  end
end
