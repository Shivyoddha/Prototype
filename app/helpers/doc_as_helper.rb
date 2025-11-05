module DocAsHelper
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

  def can_approve?(doc_a)
    case current_user.user_name
    when 'P'
      doc_a.pending_p_approval?
    when 'Q'
      doc_a.pending_q_approval?
    when 'R'
      doc_a.pending_r_approval?
    when 'S'
      doc_a.pending_s_approval?
    else
      false
    end
  end
end

