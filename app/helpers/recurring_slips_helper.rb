module RecurringSlipsHelper
  def schedule_month_options
    [
      [t('helpers.recurring_slips.schedule_months_options.every_month', :default => "Every month"), 1], 
      [t('helpers.recurring_slips.schedule_months_options.every_months', :count => 2, :default => "Every 2 months"), 2], 
      [t('helpers.recurring_slips.schedule_months_options.every_months', :count => 3, :default => "Every 3 months"), 3], 
      [t('helpers.recurring_slips.schedule_months_options.every_months', :count => 4, :default => "Every 4 months"), 4], 
      [t('helpers.recurring_slips.schedule_months_options.every_months', :count => 6, :default => "Every 6 months"), 6], 
      [t('helpers.recurring_slips.schedule_months_options.every_year', :default => "Every year"), 12], 
      [t('helpers.recurring_slips.schedule_months_options.every_years', :count => 2, :default => "Every 2 years"), 24]
    ]
  end
  def schedule_day_options
    [
      [t('helpers.recurring_slips.expiration_day_options.beginning', :default => 'At the beginning of the month'), 1], 
      [t('helpers.recurring_slips.expiration_day_options.end', :default => 'At the end of the month'), -1]
    ].concat(2.upto(30).collect { |n| [t('helpers.recurring_slips.expiration_day_options.day', :count => n, :default => "on the #{n.ordinal}"), n] })
  end
end
