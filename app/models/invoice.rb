class Invoice < ActiveRecord::Base
  include ::BaseInvoice

  belongs_to :consolidated_tax
  belongs_to :customer
  has_many :slips
  belongs_to :invoice_project

  attr_accessible :date, :number, :paid, :payment_date, :consolidated_tax_id, :slip_ids

  # Returns the invoices with consolidated taxes with at least one tax with withholding flag at true
  scope :withholding_taxes, -> { joins(consolidated_tax: :taxes).where(taxes: { withholding: true }) }

  validates :date, presence: true
  validates :customer, presence: true
  validates :consolidated_tax, presence: true
  validates :slips, presence: true
  validate :customer_must_exist
  validate :consolidated_tax_must_exist

  def self.next_option_name
    'NEXT_INVOICE_NUMBER'
  end

  # Get the sum of the slips' rates
  def rate
    sum = 0
    self.slips.each { |slip| sum += slip.rate }
    sum
  end

  # Returns the withholding rate of an invoice
  def withholding_rate
    rate = 0
    sum = self.rate
    compounds = []
    self.consolidated_tax.taxes.each do |tax|
      partial = sum * tax.rate / 100
      if tax.compound
        compounds << partial
        rate += partial if tax.withholding
      else
        compounds.each { |compound| sum += compound }
        sum += partial
        rate += partial if tax.withholding
      end
    end
    rate * (-1)
  end

  # Destroy the invoice restoring the slips or the invoice project if present
  def restore_and_destroy
    if self.invoice_project
      self.invoice_project.update_attribute(:invoiced, false)
    end

    self.slips.each do |slip|
      slip.restore
    end

    self.destroy
  end

  # Set the invoice as downloaded
  def update_download_status
    self.update_attribute(:downloaded, true) unless self.downloaded
  end

  private
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
