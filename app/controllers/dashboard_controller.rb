class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
  end
end
