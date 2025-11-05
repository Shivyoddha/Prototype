class DashboardController < ApplicationController
  def index
    @pending_doc_as = DocA.pending_user_approval(current_user.user_name)
    @pending_doc_bs = DocB.pending_user_approval(current_user.user_name)
    @my_doc_as = DocA.where(user: current_user).order(created_at: :desc).limit(10)
    @my_doc_bs = DocB.where(user: current_user).order(created_at: :desc).limit(10)
    
    # For approvers, show documents they've processed
    if current_user.approver?
      @processed_doc_as = DocA.where.not(
        case current_user.user_name
        when 'P'
          { p_date: nil }
        when 'Q'
          { q_date: nil }
        when 'R'
          { r_date: nil }
        when 'S'
          { s_date: nil }
        else
          {}
        end
      ).order(updated_at: :desc).limit(20)
      
      @processed_doc_bs = DocB.where.not(
        case current_user.user_name
        when 'P'
          { p_date: nil }
        when 'Q'
          { q_date: nil }
        when 'R'
          { r_date: nil }
        when 'S'
          { s_date: nil }
        else
          {}
        end
      ).order(updated_at: :desc).limit(20)
    else
      @processed_doc_as = []
      @processed_doc_bs = []
    end
  end
end

