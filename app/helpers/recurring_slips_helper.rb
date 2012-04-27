module RecurringSlipsHelper
  def schedule_month_options
    [["Every month", 1], ["Every 2 months", 2], ["Every 3 months", 3], ["Every 4 months", 4], ["Every 6 months", 6], ["Every year", 12], ["Every 2 years", 24]]
  end
  def schedule_day_options
    [['At the beginning of the month', 1], ['At the end of the month', -1]].concat(2.upto(30).collect { |n| ["on the #{n.ordinal}", n] })
  end
end
