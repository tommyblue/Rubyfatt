class Mysql2Adapter
  def self.get_month value
  	"MONTH(#{value})"
  end

  def self.get_year value
  	"YEAR(#{value})"
  end
end