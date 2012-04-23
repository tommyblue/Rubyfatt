class Slip < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :invoice
  belongs_to :invoice_project
  belongs_to :customer
  
  validates_presence_of :name, :rate, :customer
  
  def estimated?
    self.estimate != nil
  end
  
  def restore_from_invoice_project
    self.update_attribute(:invoice_project_id, nil)
  end
  
  def restore
    self.update_attribute(:invoice_id, nil)
  end
end
