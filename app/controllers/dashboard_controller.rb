class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
    @this_year = current_user.invoices.this_year
    @receipts_per_year = current_user.invoices.receipts_per_year
  end
end
