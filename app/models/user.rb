class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable#, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat, :phone, :bank_coordinates, :language, :logo

  has_attached_file :logo, :styles => { :medium => "600x300>" }

  has_many :customers
  has_many :options
  has_many :consolidated_taxes, :class_name => 'ConsolidatedTax'
  has_many :slips, :through => :customers
  has_many :recurring_slips, :through => :customers
  has_many :invoices, :through => :customers do
    def this_year
      self.unscoped
        .select("#{DbAdapter.get_month "invoices.date"} AS month_number,SUM(slips.rate) AS month_income")
        .joins(:slips, :customer)
        .where("#{DbAdapter.get_year "invoices.date"} = ? AND invoices.paid = ?", Time.now.year, true)
        .group("#{DbAdapter.get_month "invoices.date"}")
        .order('month_number')
    end

    def receipts_per_year
      self.unscoped
        .select("#{DbAdapter.get_year "invoices.date"} AS year_number,SUM(slips.rate) AS year_income")
        .joins(:slips, :customer)
        .group("#{DbAdapter.get_year "invoices.date"}")
        .order('year_number')
    end    
  end

  has_many :invoice_projects, :through => :customers
  has_many :work_categories

  validates_presence_of :email, :name, :surname, :address, :zip_code, :town, :province, :tax_code, :vat, :phone
  validates_uniqueness_of :email
  validates :language, :inclusion => {:in => ['it', 'en']}
  validates_attachment_content_type :logo, :content_type => /image/


  def unpaid_invoices
    invoices = []
    self.invoices.each { |invoice| invoices << invoice unless invoice.paid }
    invoices
  end

  def destroy_logo
    self.logo = nil
    self.save
  end
end
