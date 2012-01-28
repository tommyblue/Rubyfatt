class Slip < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :invoice
  belongs_to :customer
      
  def estimated?
    self.estimate != nil
  end
  
  def restore
    self.update_attribute(:invoice_id, nil)
  end
end
