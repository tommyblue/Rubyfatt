class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat
  
  has_many :customers
  has_many :options
  has_many :consolidated_taxes, :class_name => 'ConsolidatedTax'
  has_many :taxes, :class_name => 'Tax'
end
