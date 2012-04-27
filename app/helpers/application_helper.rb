module ApplicationHelper
  def expired_recurring_slips(only_num = false)
    expired = RecurringSlip.expired
    if only_num
      expired
    else
      expired > 0 ? '<span class="badge">' + expired.to_s + '</span>' : ''
    end
  end
  
  def unpaid_invoices(only_num = false)
    unpaid = current_user.unpaid_invoices.size
    if only_num
      unpaid
    else
      unpaid > 0 ? '<span class="badge badge-error">' + unpaid.to_s + '</span>' : ''
    end
  end
  
  def invoice_projects(only_num = false)
    invoice_projects = current_user.invoice_projects.size
    if only_num
      invoice_projects
    else
      invoice_projects > 0 ? '<span class="badge">' + invoice_projects.to_s + '</span>' : ''
    end
  end
end 