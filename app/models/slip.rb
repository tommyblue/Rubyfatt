class Slip < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :invoice
  belongs_to :customer
      
  def estimated?
    self.estimate != nil
  end
end
