class DbAdapter
  def self.get_adapter_class
    db_config = ActiveRecord::Base.connection_config
    "#{db_config[:adapter].capitalize}Adapter".constantize
  rescue NameError
    BaseAdapter
  end

  def self.get_month value
    get_adapter_class.get_month value
  end

  def self.get_year value
    get_adapter_class.get_year value
  end

  def self.order_asc
    get_adapter_class.order_asc
  end
end
