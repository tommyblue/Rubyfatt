class ConsolidatedTax < ActiveRecord::Base
  has_many :taxes, :class_name => 'Tax', :order => '`order` ASC'
  has_many :invoices
  has_many :estimates
end
