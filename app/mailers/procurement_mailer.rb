class ProcurementMailer < ApplicationMailer
  def document_submitted_to_approver(document, approver_name, approver_email = nil)
    @document = document
    @approver_name = approver_name
    @creator = document.user
    @document_type = document.class.name
    
    # Get email from user record if available, otherwise use provided email or default
    approver_user = User.find_by(user_name: approver_name)
    final_email = approver_user&.email.presence || approver_email || get_default_email(approver_name)
    
    mail(
      to: final_email,
      subject: "[IRIS Procurement] New Document Requires Your Approval - #{document.eq_id}"
    )
  end

  def document_approved_status(document, to_user, status_message)
    @document = document
    @to_user = to_user
    @status_message = status_message
    @document_type = document.class.name
    @display_name = to_user.respond_to?(:user_name) ? to_user.user_name : to_user.to_s
    
    # Determine email based on user object or username
    email = to_user.respond_to?(:user_name) ? get_user_email(to_user.user_name) : get_user_email(to_user.to_s)
    
    mail(
      to: email,
      subject: "[IRIS Procurement] Document Update - #{document.eq_id} - #{status_message}"
    )
  end

  def document_rejected_status(document, to_user, rejection_message)
    @document = document
    @to_user = to_user
    @rejection_message = rejection_message
    @document_type = document.class.name
    @display_name = to_user.respond_to?(:user_name) ? to_user.user_name : to_user.to_s
    
    # Determine email based on user object or username
    email = to_user.respond_to?(:user_name) ? get_user_email(to_user.user_name) : get_user_email(to_user.to_s)
    
    mail(
      to: email,
      subject: "[IRIS Procurement] Document Rejected - #{document.eq_id}"
    )
  end

  private

  def get_user_email(user_name)
    user = User.find_by(user_name: user_name)
    
    # Return configured email if available, otherwise use defaults
    if user && user.email.present?
      user.email
    else
      get_default_email(user_name)
    end
  end
  
  def get_default_email(user_name)
    case user_name
    when 'U'
      'anish.kumbhar04@gmail.com'
    when 'P', 'Q', 'R', 'S'
      'brc@nitk.edu.in'
    else
      'anish.kumbhar04@gmail.com'
    end
  end
end
