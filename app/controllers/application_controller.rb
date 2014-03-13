class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_initial_registration
  # before_action :authenticate_user!
  before_action :set_locale
  # before_action :check_new_year # TODO

  # layout :layout_by_resource

  protected

  def check_initial_registration
    redirect_to new_register_path if User.count == 0
  end

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

  # TODO
  # If the invoice number is > 1 but this year there are no invoices, probably this is a new year
  # def check_new_year
  #   if current_user && Option.get_option_value(current_user, 'NEXT_INVOICE_NUMBER') > 1 && current_user.invoices.where("#{DbAdapter.get_year "invoices.date"} = ?",Time.now.year).count == 0
  #     flash.now[:info] = '<i class="icon-info-sign"></i> ' + I18n.t(:new_year_message, default: "No invoices present for the current year, but the next invoice number isn't 1, maybe you need to reset the counters from the option's page")
  #   end
  # end
end
