class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
    @this_year = current_user.invoices.sum("slips.rate").joins(:slips).by_year(Time.now.year).group("MONTH(invoices.date)")
    # select MONTH(i.date),sum(s.rate) from slips as s join invoices as i on s.invoice_id=i.id where YEAR(i.date)=2012 group by MONTH(i.date)
    # Invoice.joins(:slips).where("YEAR(invoices.date) = ?", Time.now.year).group("MONTH(invoices.date)")
  end
end
