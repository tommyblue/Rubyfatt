class Certification < ActiveRecord::Base
  attr_accessible :customer_id, :year, :received_at, :rate, :attachment

  has_attached_file :attachment

  belongs_to :user
  belongs_to :customer

  def self.year_certification(user, year)
    totals = {}
    invoices = user.invoices.by_year(year).where.not(payment_date: nil).withholding_taxes
    invoices.each do |invoice|
      unless totals.has_key?(invoice.customer)
        totals[invoice.customer] = {}
        totals[invoice.customer][:rate] = 0
        totals[invoice.customer][:year] = year
      end
      totals[invoice.customer][:rate] += invoice.withholding_rate
    end
    totals
  end
end
