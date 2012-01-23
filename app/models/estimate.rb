class Estimate < ActiveRecord::Base
  belongs_to :customer
  has_many :slips
end
