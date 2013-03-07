class Option < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :value, :integer

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :value, presence: true
  validate :user_must_exist

  DEFAULT_VALUES = [
    {
      name: 'NEXT_ESTIMATE_NUMBER',
      value: 1,
      integer: true
    },
    {
      name: 'NEXT_INVOICE_PROJECT_NUMBER',
      value: 1,
      integer: true
    },
    {
      name: 'NEXT_INVOICE_NUMBER',
      value: 1,
      integer: true
    },
    {
      name: 'CHARTS_ENGINE',
      value: 'xcharts',
      integer: false
    }
  ]

  def self.get_option(user, key)
    value = user.options.where(name: key)
    unless value.empty?
      value.first
    else
      self.create_option(user, key)
    end
  end

  def self.create_option(user, key)
    DEFAULT_VALUES.each do |option|
      if option[:name] == key
        return user.options.create(option)
      end
    end
    raise 'OPTION NOT FOUND'
  end

  private
    def user_must_exist
      unless self.user_id.nil?
        errors[:base] << "The user doesn't exist" unless User.find_by_id(self.user_id)
      end
    end
end
