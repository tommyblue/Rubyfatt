class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_locale
  before_action :check_new_year
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, :alert => exception.message
  end

  protected

  def set_locale
    if current_user
      I18n.locale = current_user.language.to_sym || I18n.default_locale
    else
      I18n.default_locale
    end
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  # If the invoice number is > 1 but this year there are no invoices, probably this is a new year
  def check_new_year
    if Option.get_option_value(User.first, 'NEXT_INVOICE_NUMBER') > 1 && Invoice.where("#{DbAdapter.get_year "invoices.date"} = ?",Time.now.year).count == 0
      flash.now[:info] = '<i class="icon-info-sign"></i> ' + I18n.t(:new_year_message, default: "No invoices present for the current year, but the next invoice number isn't 1, maybe you need to reset the counters from the option's page")
    end
  end
end
