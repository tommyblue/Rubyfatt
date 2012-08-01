class ConsolidatedTax < ActiveRecord::Base
  has_many :taxes, :class_name => 'Tax', :order => '`order` ASC', :dependent => :destroy
  has_many :invoices
  has_many :invoice_projects
  has_many :estimates

  attr_accessible :name

  validates_uniqueness_of :name
  validates_presence_of :name

  def can_be_deleted?
    if self.invoices.empty? and self.invoice_projects.empty? and self.estimates.empty?
      return true
    else
      return false
    end
  end
end
