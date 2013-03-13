class ConsolidatedTax < ActiveRecord::Base
  belongs_to :user
  has_many :taxes, :class_name => 'Tax', :order => DbAdapter.order_asc, :dependent => :destroy
  has_many :invoices
  has_many :invoice_projects
  has_many :estimates

  attr_accessible :name, :notes

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }
  validate :user_must_exist

  def can_be_deleted?
    if self.invoices.empty? and self.invoice_projects.empty? and self.estimates.empty?
      return true
    else
      return false
    end
  end

  def suggest_order
    order = 0
    self.taxes.each { |tax| order = tax.order.to_i if tax.order.to_i > order }
    order + 1
  end

  private
    def user_must_exist
      unless self.user_id.nil?
        errors[:base] << "The user doesn't exist" unless User.find_by_id(self.user_id)
      end
    end
end
