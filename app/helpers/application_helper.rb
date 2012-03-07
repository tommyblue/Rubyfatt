module ApplicationHelper
  def expired_recurring_slips(only_num = false)
    expired = RecurringSlip.expired
    if only_num
      expired
    else
      expired > 0 ? '<span class="circle">' + expired.to_s + '</span>' : ''
    end
  end
end
