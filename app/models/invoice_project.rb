class InvoiceProject < ActiveRecord::Base
  belongs_to :consolidated_tax
  belongs_to :customer
  has_many :slips
  has_one :invoice

  default_scope order('invoice_projects.number', 'invoice_projects.id')
  scope :by_year, lambda {|year| where("date >= ? and date <= ?", "#{year}-01-01", "#{year}-12-31")}
  scope :uninvoiced, where(invoiced: false)
  scope :invoiced, where(invoiced: true)

  validates_presence_of :date, :customer, :consolidated_tax

  before_create do
    option = Option.get_option(self.customer.user, 'NEXT_INVOICE_PROJECT_NUMBER')
    self.number = option.value.to_i
  end

  after_create do
    option = Option.get_option(self.customer.user, 'NEXT_INVOICE_PROJECT_NUMBER')
    option.value = option.value.to_i + 1
    option.save!
  end

  # Get the sum of the slips' rates
  def rate
    sum = 0
    self.slips.each { |slip| sum += slip.rate }
    sum
  end

  # Applies consolidated taxes to the slip rate
  def total
    sum = self.rate
    compounds = []
    self.consolidated_tax.taxes.each do |tax|
      partial = sum * tax.rate / 100
      if tax.compound
        compounds << partial
      else
        compounds.each { |compound| sum += compound }
        sum += partial
      end
    end

    compounds.each { |compound| sum += compound }
    sum
  end

  # Destroy the invoice restoring the slips
  def restore_slips_and_destroy
    self.slips.each do |slip|
      slip.restore_from_invoice_project
    end
    self.destroy
  end

  # Transforms invoice project to invoice
  def to_invoice
    invoice = self.customer.invoices.new
    invoice.consolidated_tax = self.consolidated_tax
    invoice.date = self.date

    self.slips.each do |slip|
      invoice.slips << slip
    end

    # Link invoice to generating invoice project
    invoice.invoice_project_id = self.id

    if res = invoice.save
      self.update_attribute(:invoiced, true)
    end
    res
  end
end
