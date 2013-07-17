class Estimate < ActiveRecord::Base
  include ::BaseInvoice

  belongs_to :consolidated_tax
  belongs_to :customer
  has_many :slips

  attr_accessible :date, :number, :invoiced, :consolidated_tax_id, :slip_ids

  validates :date, presence: true
  validates :customer, presence: true
  validates :consolidated_tax, presence: true
  validates :slips, presence: true
  validate :customer_must_exist
  validate :consolidated_tax_must_exist

  def next_option_name
    'NEXT_ESTIMATE_NUMBER'
  end

  # Get the sum of the slips' rates
  def rate
    sum = 0
    self.slips.each { |slip| sum += slip.rate }
    sum
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
