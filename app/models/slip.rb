class Slip < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :invoice
  belongs_to :invoice_project
  belongs_to :customer
  has_many :time_entries

  attr_accessible :name, :rate, :timed, :duration

  validates :name, :presence => true
  validates :rate, :presence => true, :numericality => true
  validates :customer, :presence => true
  validates :duration, :numericality => true, :allow_nil => true, :allow_blank => true
  validate :customer_must_exist
  validate :estimate_must_exist
  validate :invoice_must_exist

  scope :working, where("invoice_id IS NULL AND invoice_project_id IS NULL")

  def total_hours
    (self.timed and self.time_entries.size > 0) ? self.time_entries.map(&:hours).inject(:+) : 0
  end

  def estimated?
    self.estimate != nil
  end

  def restore_from_invoice_project
    self.update_attribute(:invoice_project_id, nil)
  end

  def restore
    self.update_attribute(:invoice_id, nil)
  end

  private
    def customer_must_exist
      unless self.customer_id.nil?
        errors[:base] << "The customer doesn't exist" unless Customer.find_by_id(self.customer_id)
      end
    end

    def estimate_must_exist
      unless self.estimate_id.nil?
        errors[:base] << "The estimate doesn't exist" unless Estimate.find_by_id(self.estimate_id)
      end
    end

    def invoice_must_exist
      unless self.invoice_id.nil?
        errors[:base] << "The invoice doesn't exist" unless Invoice.find_by_id(self.invoice_id)
      end
    end
end
