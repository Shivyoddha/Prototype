class DocA < ApplicationRecord
  belongs_to :user
  
  enum status: {
    draft: 0,
    pending_p_approval: 1,
    pending_q_approval: 2,
    pending_r_approval: 3,
    pending_s_approval: 4,
    approved: 5,
    rejected: 6
  }

  validates :eq_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :head, presence: true

  scope :pending_user_approval, ->(user_name) {
    case user_name
    when 'P'
      where(status: :pending_p_approval)
    when 'Q'
      where(status: :pending_q_approval)
    when 'R'
      where(status: :pending_r_approval)
    when 'S'
      where(status: :pending_s_approval)
    else
      none
    end
  }

  def next_status
    return :pending_p_approval if draft?
    return :pending_q_approval if pending_p_approval?
    return :pending_r_approval if pending_q_approval?
    return :pending_s_approval if pending_r_approval?
    :approved if pending_s_approval?
  end

  def approve!(user_name)
    case user_name
    when 'P'
      update!(status: :pending_q_approval, p_date: Time.current)
    when 'Q'
      update!(status: :pending_r_approval, q_date: Time.current)
    when 'R'
      update!(status: :pending_s_approval, r_date: Time.current)
    when 'S'
      update!(status: :approved, s_date: Time.current)
    end
  end

  def reject!(remarks)
    update!(status: :rejected)
  end
end

