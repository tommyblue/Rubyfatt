module InvoicesHelper
  def get_selectable_invoices_years
    years = []
    current_user.invoices.select('YEAR(date) AS year').group('YEAR(date)').each { |group| years << group.year }
    years
  end
end
