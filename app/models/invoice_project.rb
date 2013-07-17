class InvoiceProject < ActiveRecord::Base
  include ::BaseInvoice

  belongs_to :consolidated_tax
  belongs_to :customer
  has_many :slips
  has_one :invoice

  attr_accessible :date, :number, :invoiced, :consolidated_tax_id, :slip_ids

  scope :uninvoiced, -> { where(invoiced: false) }
  scope :invoiced, -> { where(invoiced: true) }

  validates :date, presence: true
  validates :customer, presence: true
  validates :consolidated_tax, presence: true
  validates :slips, presence: true
  validate :customer_must_exist
  validate :consolidated_tax_must_exist

  before_destroy :clear_invoice_relation

  def next_option_name
    'NEXT_INVOICE_PROJECT_NUMBER'
  end

  # Get the sum of the slips' rates
  def rate
    sum = 0
    self.slips.each { |slip| sum += slip.rate }
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
  def to_invoice(invoice_data)
    invoice = self.customer.invoices.new
    invoice.consolidated_tax = self.consolidated_tax
    invoice.date = invoice_data[:date]
    invoice.paid = invoice_data[:paid]
    invoice.payment_date = invoice_data[:payment_date]

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

  # Set the invoice project as downloaded
  def update_download_status
    self.update_attribute(:downloaded, true) unless self.downloaded
  end

  private
    def clear_invoice_relation
      self.invoice.update_attribute(:invoice_project_id, nil) if self.invoice
    end

    def customer_must_exist
      unless self.customer_id.nil?
        errors[:base] << "The customer doesn't exist" unless Customer.find_by_id(self.customer_id)
      end
    end

    def consolidated_tax_must_exist
      unless self.consolidated_tax_id.nil?
        errors[:base] << "The consolidated tax doesn't exist" unless ConsolidatedTax.find_by_id(self.consolidated_tax_id)
      end
    end
end
