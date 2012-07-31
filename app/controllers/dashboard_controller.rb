class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
    @this_year = Invoice.select('MONTH(invoices.date) AS month_number,SUM(slips.rate) AS month_income').joins(:slips, :customer).where("customers.user_id = ? AND YEAR(invoices.date) = ?", current_user.id, Time.now.year).group("MONTH(invoices.date)")
    @receipts_per_year = Invoice.select('YEAR(invoices.date) AS year_number,SUM(slips.rate) AS year_income').joins(:slips, :customer).where("customers.user_id = ?", current_user.id).group("YEAR(invoices.date)")
  end
end
