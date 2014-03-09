class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable#, :trackable, :validatable, :registerable

  has_attached_file :logo, styles: { medium: "600x300>" }

  has_many :customers
  has_many :options
  has_many :consolidated_taxes, class_name: 'ConsolidatedTax'
  has_many :slips, through: :customers
  has_many :recurring_slips, through: :customers
  has_many :invoices, through: :customers, extend: InvoicePerYear
  has_many :invoice_projects, through: :customers
  has_many :work_categories
  has_many :certifications
  has_many :tokens, dependent: :destroy

  validates_presence_of :email, :name, :surname, :address, :zip_code, :town, :province, :tax_code, :vat, :phone
  validates_uniqueness_of :email
  validates :language, inclusion: {in: ['it', 'en']}
  validates_attachment_content_type :logo, content_type: /image/

  # Authenticate a user by token
  def self.authenticate_with_token(token_hash)
    if (token = Token.find_by_token(token_hash)) && token.is_valid?
      token.user
    else
      false
    end
  end

  # Sign in the user from API and returns a valid token if correct
  def self.api_login(email, password)
    if (user = User.find_by_email(email)) && user.valid_password?(password)
      token = user.tokens.create
      token.token
    else
      false
    end
  end

  # Return last user token
  def token
    if t = self.tokens.last
      t.token
    else
      nil
    end
  end

  def get_option_value(key)
    if self.options.where(name: key).any?
      Option.get_option_value(self, key)
    else
      nil
    end
  end

  def full_name
    [self.title, self.name, self.surname].join(' ')
  end

  def unpaid_invoices
    invoices = []
    self.invoices.each { |invoice| invoices << invoice unless invoice.paid? }
    invoices
  end

  def destroy_logo
    self.logo = nil
    self.save
  end

  def self.generate_password
    require 'securerandom'
    SecureRandom.hex(5)
  end
end
