class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :estimates, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_projects, dependent: :destroy
  has_many :slips, dependent: :destroy
  has_many :recurring_slips, dependent: :destroy
  has_many :working_slips, -> { where('invoice_id IS NULL AND invoice_project_id IS NULL') }, class_name: 'Slip', dependent: :destroy
  has_many :certifications, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :vat, uniqueness: { scope: :user_id }, allow_nil: true, allow_blank: true

  scope :ordered, -> { order(:title) }

  # Show the correct customer heading: title, if present or full name instead
  def heading
    self.title.blank? ? self.full_name : self.title
  end

  def full_name
    [name, surname].join(' ')
  end

  def billed
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total }
    sum
  end

  def paid?
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total if invoice.paid? }
    sum
  end
  alias_method :paid, :paid?

  def unpaid
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total unless invoice.paid }
    sum
  end

  def can_be_deleted?
    if self.estimates.empty? and self.invoices.empty? and self.invoice_projects.empty? and self.slips.empty? and self.recurring_slips.empty?
      return true
    else
      return false
    end
  end
end
