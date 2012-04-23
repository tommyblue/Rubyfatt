class ConsolidatedTax < ActiveRecord::Base
  has_many :taxes, :class_name => 'Tax', :order => '`order` ASC'
  has_many :invoices
  has_many :invoice_projects
  has_many :estimates
end
