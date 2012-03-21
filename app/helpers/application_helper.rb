module ApplicationHelper
  def expired_recurring_slips(only_num = false)
    expired = RecurringSlip.expired
    if only_num
      expired
    else
      expired > 0 ? '<span class="circle">' + expired.to_s + '</span>' : ''
    end
  end
  
  def unpaid_invoices(only_num = false)
    unpaid = current_user.unpaid_invoices.size
    if only_num
      unpaid
    else
      unpaid > 0 ? '<span class="circle">' + unpaid.to_s + '</span>' : ''
    end
  end
end
