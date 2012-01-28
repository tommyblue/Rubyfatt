class RecurringSlip < ActiveRecord::Base
  include IceCube
  serialize :schedule, Hash
  
  belongs_to :customer
  
  validates_presence_of :name, :rate, :customer, :schedule
  
  def estimated?
    self.estimate != nil
  end
  
  def restore
    self.update_attribute(:invoice_id, nil)
  end
  
  # To assign a schedule just use IceCube::Rule as parameter
  # Example:
  # RecurringSlip.create(:customer_id => 1, :name => 'test', :rate => 100.0, :schedule => IceCube::Rule.monthly.day_of_month(1))
  def schedule=(rule)
    new_schedule = IceCube::Schedule.new
    new_schedule.add_recurrence_rule rule
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end
end

#rule = IceCube::Rule.monthly.day_of_month(1)
#schedule = IceCube::Schedule.new
#schedule.add_recurrence_rule rule