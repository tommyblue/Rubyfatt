class ReportsController < ApplicationController

  def unpaid_invoices
    @invoices = current_user.unpaid_invoices
    authorize! :read, Invoice
  end
end
