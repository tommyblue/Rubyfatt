module SlipsHelper
  def check_slip_duration(slip)
    if slip.timed
      slip.total_hours > slip.duration ? "<span class=\"label label-important\">#{slip.duration}</span>" : "#{slip.duration}"
    else
      '-'
    end
  end
end
