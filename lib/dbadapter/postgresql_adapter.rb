class PostgresqlAdapter
  def self.get_month value
  	get_date_part "MONTH", value
  end

  def self.get_year value
  	get_date_part "YEAR", value
  end

  def self.get_date_part date_part, value
  	"EXTRACT(#{date_part} FROM #{value})"
  end

  def self.order_asc
  	'"order" ASC'
  end
end