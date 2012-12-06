class Sqllite3Adapter
  def self.get_month value
  	get_date_part "m", value
  end

  def self.get_year value
  	get_date_part "Y", value
  end

  def self.get_date_part date_part, value
  	"strftime('%#{date_part}', #{value})"
  end
end