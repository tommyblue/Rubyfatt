class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)

    @this_year = Invoice.this_year current_user.id
    @receipts_per_year = Invoice.receipts_per_year current_user.id
  end
end
