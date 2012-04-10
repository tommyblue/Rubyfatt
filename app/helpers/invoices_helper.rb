module InvoicesHelper
  def get_selectable_invoices_years
    years = []
    # Had to disable this method because Sqlite doesn't like it... :(
    #current_user.invoices.select('YEAR(date) AS year').group('YEAR(date)').each { |group| years << group.year }
    current_user.invoices.each { |invoice| (years << invoice.date.year) unless years.include?(invoice.date.year) }
    years
  end
end
