module InvoicePerYear
  def this_year
    select("#{DbAdapter.get_month "invoices.date"} AS month_number,SUM(slips.rate) AS month_income")
      .joins(:slips, :customer)
      .where("#{DbAdapter.get_year "invoices.date"} = ? AND invoices.paid = ?", Time.now.year, true)
      .group("#{DbAdapter.get_month "invoices.date"}")
      .order('month_number')
  end

  def receipts_per_year
    select("#{DbAdapter.get_year "invoices.date"} AS year_number,SUM(slips.rate) AS year_income")
      .joins(:slips, :customer)
      .group("#{DbAdapter.get_year "invoices.date"}")
      .order('year_number')
  end    
end