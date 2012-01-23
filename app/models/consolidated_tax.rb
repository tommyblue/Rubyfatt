class ConsolidatedTax < ActiveRecord::Base
  has_many :taxes, :class_name => 'Tax'
  has_many :items
end
