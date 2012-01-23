class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :estimates
  has_many :invoices
  has_many :slips
end
