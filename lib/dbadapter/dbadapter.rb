class Dbadapter
  def self.get_adapter_class
    db_config = ActiveRecord::Base.connection_config
    Object.const_get("#{db_config[:adapter].capitalize}Adapter")
 end

  def self.get_month value
    get_adapter_class.get_month value
  end

  def self.get_year value
    get_adapter_class.get_year value
  end
end