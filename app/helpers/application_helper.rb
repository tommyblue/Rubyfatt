module ApplicationHelper
  def expired_recurring_slips_badge(only_num = false)
    expired = RecurringSlip.expired
    if only_num
      expired
    else
      expired > 0 ? '<span class="badge">' + expired.to_s + '</span>' : ''
    end
  end

  def unpaid_invoices_badge(only_num = false)
    unpaid = current_user.unpaid_invoices.size
    if only_num
      unpaid
    else
      unpaid > 0 ? '<span class="badge badge-error">' + unpaid.to_s + '</span>' : ''
    end
  end

  def invoice_projects_badge(only_num = false)
    invoice_projects = current_user.invoice_projects.uninvoiced.size
    if only_num
      invoice_projects
    else
      invoice_projects > 0 ? '<span class="badge">' + invoice_projects.to_s + '</span>' : ''
    end
  end

  def working_slips_badge(only_num = false)
    slips = current_user.slips.working.size
    if only_num
      slips
    else
      slips > 0 ? '<span class="badge">' + slips.to_s + '</span>' : ''
    end
  end

  def print_breadcrumbs(array_path)
    return_value = "<ul class=\"breadcrumb\">\n\t<li><a href=\"#{root_url}\">"+I18n.t('breadcrumb.dashboard', :default => "Dashboard")+"</a><span class=\"divider\">/</span></li>\n\t"
    last_element = array_path.pop

    array_path.each do |path|
      return_value += "<li><a href=\"#{path[1]}\">#{path[0]}</a><span class=\"divider\">/</span></li>\n\t"
    end

    return_value += "<li class=\"active\">#{last_element[0]}</li>\n\t"
    return_value += "</ul>\n"
  end

  def active_navbar_helper(regexp_path, hide_wrapper = false)
    if hide_wrapper
      regexp_path.match(request.path) ? ' active' : ''
    else
      regexp_path.match(request.path) ? ' class="active"' : ''
    end
  end
end
