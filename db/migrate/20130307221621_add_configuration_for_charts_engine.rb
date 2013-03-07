class AddConfigurationForChartsEngine < ActiveRecord::Migration
  def up
    User.all.each do |user|
      Option.create_option(user, 'CHARTS_ENGINE')
    end
  end

  def down
  end
end
