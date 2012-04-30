class Customer < ActiveRecord::Base
  default_scope order('customers.title', 'customers.id')
  belongs_to :user
  has_many :estimates
  has_many :invoices
  has_many :invoice_projects
  has_many :slips
  has_many :recurring_slips
  
  has_many :working_slips, :class_name => 'Slip', :conditions => ['invoice_id IS NULL AND invoice_project_id IS NULL']
  
  def billed
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total }
    sum
  end
  
  def paid
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total if invoice.paid }
    sum
  end
  
  def unpaid
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total unless invoice.paid }
    sum
  end
end
