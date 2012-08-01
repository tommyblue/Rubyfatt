class Tax < ActiveRecord::Base
  belongs_to :consolidated_tax

  validates_numericality_of :order
  validates_numericality_of :rate
  validates_presence_of :name
  validates_presence_of :rate
  validates :compound, :inclusion => { :in => [true, false] }
end
