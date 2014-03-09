class RecurringSlip < ActiveRecord::Base
  include IceCube
  serialize :schedule, Hash

  belongs_to :customer
  has_one :user, through: :customer

  validates :name, presence: true
  validates :rate, presence: true, numericality: true
  validates :customer, presence: true
  validates :schedule, presence: true
  validate :customer_must_exist
  validate :check_customer_on_save, on: :save

  before_create do
    self.next_occurrence = self.schedule.next_occurrence unless self.next_occurrence
  end

  def force_next_occurrence(next_occurrence)
    self.update_attribute(:next_occurrence, next_occurrence)
  end

  def to_invoice?
    self.next_occurrence and self.next_occurrence < Time.now
  end

  # Changes the next occurrence of the slip
  def goto_next_occurrence!
    self.next_occurrence = self.schedule.next_occurrence
    self.save!
  end

  def estimated?
    self.estimate != nil
  end

  def restore
    self.update_attribute(:invoice_id, nil)
  end

  def self.expired
    sum = 0
    self.all.each do |slip|
      sum += 1 if slip.expired?
    end
    sum
  end

  def expired?
    if self.last_occurrence
      self.schedule.occurs_between?(self.schedule.last_occurrence, Time.now)
    else
      #self.schedule.occurs_between?(self.schedule.first, Time.now)
      self.to_invoice?
    end
  end

  def start_date=(datetime)
    tmp = self.schedule
    tmp.start_time = Time.parse(datetime.strftime("%Y-%m-%d %H:%M:%S %z"))
    self.schedule = tmp
    #self.save
  end

  def start_date
    self.schedule.start_time
  end

  # To assign a schedule just use IceCube::Schedule as parameter
  # Example:
  # rule = IceCube::Rule.monthly.day_of_month(1)
  # schedule = IceCube::Schedule.new
  # schedule.add_recurrence_rule rule
  # RecurringSlip.create(customer_id: 1, name: 'test', rate: 100.0, schedule: schedule)
  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end

  def check_customer_on_save
    if customer.user_id != current_user.user_id
      errors.add(:check_customer, t('controllers.recurring_slips.save.error', default: "Customer incorrect"))
    end
  end

  private
    def customer_must_exist
      errors[:base] << "The customer doesn't exist" unless Customer.find_by_id(self.customer_id)
    end
end
