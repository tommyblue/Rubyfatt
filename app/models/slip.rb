class Slip < ActiveRecord::Base
  belongs_to :consolidated_tax
  belongs_to :estimate
  belongs_to :invoice
  belongs_to :customer
  
  def estimated?
    !self.estimate_id == nil
  end
end
