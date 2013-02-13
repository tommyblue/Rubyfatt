class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
    @this_year = current_user.invoices.this_year
    @this_year_totals = {}
    @year_invoices.each do |i|
      @this_year_totals[i.date.month] = 0 unless @this_year_totals.has_key?(i.date.month)
      @this_year_totals[i.date.month] += i.total
    end
    @receipts_per_year = current_user.invoices.receipts_per_year
  end
end
