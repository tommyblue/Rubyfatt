class TimeEntry < ActiveRecord::Base
  attr_accessible :date, :hours, :comments, :work_category_id

  belongs_to :work_category
  belongs_to :slip

  validates_presence_of :date
  validates_presence_of :hours
  validates_numericality_of :hours

  validate :slip_must_exist

  private
    def slip_must_exist
      unless self.slip_id.nil?
        errors[:base] << "The slip doesn't exist" unless Slip.find_by_id(self.slip_id)
      end
    end
end
