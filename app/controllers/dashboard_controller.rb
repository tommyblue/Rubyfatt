class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @year_invoices = current_user.invoices.by_year(Time.now.year)
		a = ActiveRecord::Base.connection_config
		if a[:adapter] == "mysql2"
			@this_year = Invoice.unscoped.select('MONTH(invoices.date) AS month_number,SUM(slips.rate) AS month_income').joins(:slips, :customer).where("customers.user_id = ? AND YEAR(invoices.date) = ? AND invoices.paid = ?", current_user.id, Time.now.year, true).group("MONTH(invoices.date)").order('month_number')
	  	@receipts_per_year = Invoice.unscoped.select('YEAR(invoices.date) AS year_number,SUM(slips.rate) AS year_income').joins(:slips, :customer).where("customers.user_id = ?", current_user.id).group("YEAR(invoices.date)").order('year_number')
		else if a[:adapter] == "sqlite3"
	  	@this_year = Invoice.unscoped.select("strftime('%m',invoices.date) AS month_number,SUM(slips.rate) AS month_income").joins(:slips, :customer).where("customers.user_id = ? AND strftime('%Y',invoices.date) = ? AND invoices.paid = ?", current_user.id, Time.now.year, true).group("strftime('%m',invoices.date)").order('month_number')
	  	@receipts_per_year = Invoice.unscoped.select("strftime('%Y',invoices.date) AS year_number,SUM(slips.rate) AS year_income").joins(:slips, :customer).where("customers.user_id = ?", current_user.id).group("strftime('%Y',invoices.date)").order('year_number')
		else if a[:adapter] == "postgresql"
	  	@this_year = Invoice.unscoped.select("EXTRACT(MONTH FROM invoices.date) AS month_number,SUM(slips.rate) AS month_income").joins(:slips, :customer).where("customers.user_id = ? AND EXTRACT(YEAR FROM invoices.date) = ? AND invoices.paid = ?", current_user.id, Time.now.year, true).group("EXTRACT(MONTH FROM invoices.date)").order('month_number')
	  	@receipts_per_year = Invoice.unscoped.select("EXTRACT(YEAR FROM invoices.date) AS year_number,SUM(slips.rate) AS year_income").joins(:slips, :customer).where("customers.user_id = ?", current_user.id).group("EXTRACT(YEAR FROM invoices.date)").order('year_number')
		end
  end
end
