class ReportsController < ApplicationController
  def unpaid_invoices
    @invoices = current_user.unpaid_invoices
  end
end
