class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :estimates
  has_many :invoices
  has_many :slips
  
  has_many :working_slips, :class_name => 'Slip', :conditions => ['invoice_id IS NULL']
end
