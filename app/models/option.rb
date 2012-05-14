class Option < ActiveRecord::Base
  belongs_to :user

  DEFAULT_VALUES = [
    {
      :name => 'NEXT_ESTIMATE_NUMBER',
      :value => 1,
      :integer => true
    },
    {
      :name => 'NEXT_INVOICE_PROJECT_NUMBER',
      :value => 1,
      :integer => true
    },
    {
      :name => 'NEXT_INVOICE_NUMBER',
      :value => 1,
      :integer => true
    }
  ]

  def self.get_option(user, key)
    value = user.options.where(:name => key)
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
end
