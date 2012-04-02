class Customer < ActiveRecord::Base
  default_scope order('customers.title', 'customers.id')
  belongs_to :user
  has_many :estimates
  has_many :invoices
  has_many :slips
  has_many :recurring_slips
  
  has_many :working_slips, :class_name => 'Slip', :conditions => ['invoice_id IS NULL']
end
