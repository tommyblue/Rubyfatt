class Customer < ActiveRecord::Base
  #default_scope order('customers.title', 'customers.id')
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

  def can_be_deleted?
    if self.estimates.empty? and self.invoices.empty? and self.invoice_projects.empty? and self.slips.empty? and self.recurring_slips.empty?
      return true
    else
      return false
    end
  end
end