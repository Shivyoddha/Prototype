module DashboardHelper
  def badge_color_for_status(status)
    case status
    when 'approved'
      'success'
    when 'rejected'
      'danger'
    when 'draft'
      'info'
    else
      'warning'
    end
  end
end


