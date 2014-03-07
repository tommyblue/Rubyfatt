class WorkCategory < ActiveRecord::Base
  has_many :time_entries
  belongs_to :user

  validates_uniqueness_of :label
  validates_presence_of :label
end
