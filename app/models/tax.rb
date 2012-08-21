class Tax < ActiveRecord::Base
  belongs_to :consolidated_tax

  attr_accessible :order, :name, :rate, :compound

  validates :order, :numericality => true, :presence => true
  validates :rate, :numericality => true, :presence => true
  validates :name, :presence => true, :uniqueness => { :scope => :consolidated_tax_id }
  validates :compound, :inclusion => { :in => [true, false] }
  validate :consolidated_tax_must_exist

  private
    def consolidated_tax_must_exist
      unless self.consolidated_tax_id.nil?
        errors[:base] << "The consolidated tax doesn't exist" unless ConsolidatedTax.find_by_id(self.consolidated_tax_id)
      end
    end
end
