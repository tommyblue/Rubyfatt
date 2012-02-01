module ApplicationHelper
  def expired_recurring_slips
    expired = RecurringSlip.expired
    expired > 0 ? '<span class="circle">' + expired.to_s + '</span>' : ''
  end
end
