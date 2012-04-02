class Invoice < ActiveRecord::Base
  belongs_to :consolidated_tax
  belongs_to :customer
  has_many :slips
  
  default_scope order('invoices.number', 'invoices.id')
  scope :by_year, lambda {|year| where("date >= ? and date <= ?", "#{year}-01-01", "#{year}-12-31")}
  
  validates_presence_of :date, :customer, :consolidated_tax
  
  before_save do
    self.number = self.customer.user.options.where(:name => 'NEXT_INVOICE_NUMBER').first.value.to_i
  end
    
  after_save do
    opt = self.customer.user.options.where(:name => 'NEXT_INVOICE_NUMBER').first
    opt.value = opt.value.to_i + 1
    opt.save!
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
      slip.restore
    end
    self.destroy
  end
end
