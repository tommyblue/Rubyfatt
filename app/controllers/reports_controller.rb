class ReportsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def unpaid_invoices
    @invoices = current_user.unpaid_invoices
  end
end
