class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :estimates
  has_many :invoices
  has_many :invoice_projects
  has_many :slips
  has_many :recurring_slips
  has_many :working_slips, -> { where('invoice_id IS NULL AND invoice_project_id IS NULL') }, class_name: 'Slip'
  has_many :certifications

  attr_accessible :title, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat, :info

  validates :user, presence: true
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :vat, uniqueness: { scope: :user_id }, allow_nil: true, allow_blank: true

  scope :ordered, -> { order(:title, :name, :surname) }

  def billed
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total }
    sum
  end

  def paid
    sum = 0
    self.invoices.each { |invoice| sum += invoice.total if invoice.paid }
    sum
  end

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
